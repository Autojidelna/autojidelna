import 'dart:convert';

import 'package:autojidelna/core/notifications/notification_channel_service.dart';
import 'package:autojidelna/core/utils/url.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/core/types/freezed/account/account.dart';
import 'package:autojidelna/core/types/freezed/logged_accounts/logged_accounts.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/core/types/freezed/user/user.dart';
import 'package:autojidelna/shared/config/secure_storage.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';

import 'package:icanteenlib/canteenlib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AuthService {
  AuthService(this._ref);
  final Ref _ref;

  /// Main logic for loging in.
  /// Can throw:
  ///
  /// [AuthErrors.connectionFailed] - Connection to the canteen server failed
  ///
  /// [AuthErrors.noInternetConnection] - The user doesn't have an internet connection
  ///
  /// [AuthErrors.wrongCredentials] - The user has entered incorrect credentials
  ///
  /// [AuthErrors.wrongUrl] - The user has entered an invalid URL
  Future<User?> login(Account account) async {
    String url = Url.clean(account.url);
    User? user;

    Canteen instance = await Canteen.create(url);

    try {
      // First login attempt (with cleaned URL)
      if (!await instance.login(account.username, account.password)) {
        return Future.error(AuthErrors.wrongCredentials);
      }
    } catch (_) {
      // Second login attempt
      url = account.url;
      instance = await Canteen.create(url);

      try {
        if (!await instance.login(account.username, account.password)) {
          return Future.error(AuthErrors.wrongCredentials);
        }
      } catch (e) {
        // Check for internet connectivity
        if (!await InternetConnectionChecker.instance.hasConnection) {
          return Future.error(AuthErrors.noInternetConnection);
        }

        if (e == CanteenLibExceptions.neplatneUrl) return Future.error(AuthErrors.wrongUrl);

        return Future.error(AuthErrors.connectionFailed);
      }
    }

    _ref.read(currentCanteen.notifier).state = instance;

    try {
      user = User(
        accountData: SafeAccount.fromAccount(account),
        data: await instance.ziskejUzivatelskeUdaje(),
        stavUctuStream: instance.stavUctuStream,
      );
    } catch (e) {
      rethrow;
    }

    if (!await _hasDuplicates(account)) {
      await _saveAccountToStorage(account);
      NotificationChannelService().createChannelsForUser(SafeAccount.fromAccount(account));
    }

    return user;
  }

  /// Logs in by provided [safeAccount]
  /// Can throw:
  ///
  /// [AuthErrors.accountNotFound] - A matching [Account] was not found
  Future<User?> loginBySafeAccount(SafeAccount safeAccount) async {
    Account? account = await _findBySafeAccount(safeAccount);
    if (account == null) return Future.error(AuthErrors.accountNotFound);

    return login(account);
  }

  /// Logs in using data saved in Secure storage
  ///
  /// Can throw:
  ///
  /// [AuthErrors.accountNotFound] - A matching [Account] was not found
  ///
  /// [AuthErrors.missingCredentials] - Secure storage doesn't contain any credentials
  Future<User?> loginFromStorage() async {
    final LoggedAccounts loginData = await _getDataFromStorage();

    if (loginData.accounts.isEmpty) return Future.error(AuthErrors.missingCredentials);
    if (loginData.loggedInAccount == null) return Future.error(AuthErrors.accountNotSelected);
    return await loginBySafeAccount(loginData.loggedInAccount!);
  }

  /// Sets [LoggedAccounts.loggedInAccount] to null. Doesn't delete user credentials
  Future<void> ghostLogout() async {
    final LoggedAccounts loginData = await _getDataFromStorage();
    loginData.loggedInAccount = null;
    await _saveDataToStorage(loginData);
  }

  Future<List<SafeAccount>> getLimitedAccounts() async {
    return (await _getDataFromStorage()).accounts.map(SafeAccount.fromAccount).toList();
  }

  /// Changes [LoggedAccounts.loggedInAccount] to the provided [saveAccount]
  ///
  /// [AuthService.loginFromStorage] NEEDS TO BE CALLED AFTER THIS
  Future<void> changeAccount(SafeAccount saveAccount) async {
    LoggedAccounts loginData = await _getDataFromStorage();

    bool accountFound = loginData.accounts.any((account) => SafeAccount.fromAccount(account) == saveAccount);
    if (!accountFound) return Future.error(AuthErrors.accountNotFound);

    LoggedAccounts updatedData = LoggedAccounts(accounts: loginData.accounts, loggedInAccount: saveAccount);
    await _saveDataToStorage(updatedData);
  }

  Future<UzivatelskeUdaje?> fetchUserData(String username) async {
    Canteen? instance = _ref.read(currentCanteen);
    if (instance == null) return null;
    return await instance.ziskejUzivatelskeUdaje();
  }

  /// Logs out a specific user
  ///
  /// Can throw:
  ///
  /// [AuthErrors.accountNotFound] - A matching [Account] was not found
  Future<void> logout(SafeAccount safeAccount) async {
    Account? account = await _findBySafeAccount(safeAccount);
    if (account == null) return Future.error(AuthErrors.accountNotFound);

    await _removeAccountFromStorage(account);
    NotificationChannelService().removeChannelsForUser(safeAccount);
  }

  /// Checks for duplicates in logged accounts.
  ///
  /// Compares [Account.url] and [Account.username]
  Future<bool> _hasDuplicates(Account account) async {
    LoggedAccounts loginData = await _getDataFromStorage();
    for (Account loggedAccount in loginData.accounts) {
      if (loggedAccount.isSame(account)) return true;
    }
    return false;
  }

  /// Finds user in [LoggedAccounts], returns null if a matching account isn't found.
  Future<Account?> _findBySafeAccount(SafeAccount safeAccount) async {
    LoggedAccounts loginData = await _getDataFromStorage();
    for (Account account in loginData.accounts) {
      if (safeAccount.matches(account)) return account;
    }
    return null;
  }

  /// Reads [LoggedAccounts] from Secure storage.
  Future<LoggedAccounts> _getDataFromStorage() async {
    const secureStorage = SecureStorage.instance;
    String? value = await secureStorage.read(key: SecureStorage.keys.loginData);
    if (value == null || value.trim().isEmpty) return LoggedAccounts();
    return LoggedAccounts.fromJson(jsonDecode(value));
  }

  /// Saves [LoggedAccounts] to Secure storage.
  Future<void> _saveDataToStorage(LoggedAccounts loginData) async {
    const secureStorage = SecureStorage.instance;
    await secureStorage.write(key: SecureStorage.keys.loginData, value: jsonEncode(loginData.toJson()));
  }

  /// Saves an [Account] to Secure storage.
  Future<void> _saveAccountToStorage(Account account) async {
    LoggedAccounts loginData = await _getDataFromStorage();
    LoggedAccounts updatedData = LoggedAccounts(loggedInAccount: SafeAccount.fromAccount(account), accounts: [...loginData.accounts, account]);
    await _saveDataToStorage(updatedData);
  }

  /// Removes an [Account] from Secure storage.
  Future<void> _removeAccountFromStorage(Account account) async {
    LoggedAccounts loginData = await _getDataFromStorage();
    LoggedAccounts updatedData = LoggedAccounts(
      loggedInAccount: loginData.loggedInAccount!.matches(account) ? null : loginData.loggedInAccount,
      accounts: List.from(loginData.accounts)..remove(account),
    );
    await _saveDataToStorage(updatedData);
  }
}

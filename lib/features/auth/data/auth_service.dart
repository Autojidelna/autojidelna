import 'package:autojidelna/core/notifications/notification_channel_service.dart';
import 'package:autojidelna/core/utils/url.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/core/types/freezed/account/account.dart';
import 'package:autojidelna/core/types/freezed/logged_accounts/logged_accounts.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/core/types/freezed/user/user.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';
import 'package:autojidelna/shared/services/credentials_service.dart';

import 'package:canteenlib/canteenlib.dart';
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

    Canteen instance = Canteen(url);

    try {
      // First login attempt (with cleaned URL)
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

    _ref.read(currentCanteenProvider.notifier).state = instance;

    try {
      user = User(
        accountData: SafeAccount.fromAccount(account),
        canteenLocations: (await instance.jidelnicekDen()).vydejny,
        data: await fetchUserData(account.username),
      );
    } catch (e) {
      rethrow;
    }

    // TODO: use savedAccountsProvider.add instead
    await CredentialsService.save(account);
    NotificationChannelService().createChannelsForUser(SafeAccount.fromAccount(account));
    return user;
  }

  /// Logs in using data saved in Secure storage
  ///
  /// Can throw:
  ///
  /// [AuthErrors.accountNotFound] - A matching [Account] was not found
  ///
  /// [AuthErrors.missingCredentials] - Secure storage doesn't contain any credentials
  Future<User?> loginFromStorage() async {
    Account? account = await CredentialsService.getLastUsed();
    if (account == null) return Future.error(AuthErrors.accountNotFound);

    return await login(account);
  }

  /// Changes [LoggedAccounts.loggedInAccount] to the provided [saveAccount]
  ///
  /// [AuthService.loginFromStorage] NEEDS TO BE CALLED AFTER THIS
  Future<void> changeAccount(SafeAccount saveAccount) async {
    CredentialsService.setLastUsed(saveAccount);
  }

  Future<Uzivatel> fetchUserData(String username) async {
    Canteen instance = _ref.read(currentCanteenProvider)!;
    return instance.missingFeatures.contains(Features.ziskatUzivatele) ? Uzivatel(uzivatelskeJmeno: username) : await instance.ziskejUzivatele();
  }

  Future<void> logout(SafeAccount safeAccount) async {
    await CredentialsService.remove(safeAccount);
    NotificationChannelService().removeChannelsForUser(safeAccount);
  }
}

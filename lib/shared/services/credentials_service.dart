import 'dart:convert';

import 'package:autojidelna/core/types/freezed/account/account.dart';
import 'package:autojidelna/core/types/freezed/logged_accounts/logged_accounts.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/shared/config/secure_storage.dart';

class CredentialsService {
  static Future<LoggedAccounts> read() async {
    String? value = await SecureStorage.instance.read(key: SecureStorage.keys.loginData);
    if (value == null || value.trim().isEmpty) return LoggedAccounts();
    return LoggedAccounts.fromJson(jsonDecode(value));
  }

  static Future<LoggedAccounts> _write(LoggedAccounts loginData) async {
    await SecureStorage.instance.write(key: SecureStorage.keys.loginData, value: jsonEncode(loginData.toJson()));
    return await read();
  }

  static Future<Set<SafeAccount>> getSafeAccounts() async {
    return (await CredentialsService.read()).accounts.map(SafeAccount.fromAccount).toSet();
  }

  static Future<LoggedAccounts> save(Account account) async {
    LoggedAccounts loginData = await read();
    LoggedAccounts updatedData = LoggedAccounts(
      loggedInAccount: SafeAccount.fromAccount(account),
      accounts: loginData.accounts..add(account),
    );
    await _write(updatedData);
    return read();
  }

  static Future<LoggedAccounts> remove(SafeAccount safeAccount) async {
    LoggedAccounts loginData = await read();

    final account = await _findBySafeAccount(safeAccount);
    if (account == null) return loginData;

    LoggedAccounts updatedData = LoggedAccounts(
      loggedInAccount: loginData.loggedInAccount!.matches(account) ? null : loginData.loggedInAccount,
      accounts: loginData.accounts..remove(account),
    );
    await _write(updatedData);
    return await read();
  }

  static Future<LoggedAccounts> setLastUsed(SafeAccount? safeAccount) async {
    LoggedAccounts loginData = await read();

    bool accountFound = safeAccount == null ? true : loginData.accounts.any((account) => SafeAccount.fromAccount(account) == safeAccount);
    if (!accountFound) return loginData;

    LoggedAccounts updatedData = LoggedAccounts(loggedInAccount: safeAccount, accounts: loginData.accounts);
    await _write(updatedData);
    return await read();
  }

  static Future<Account?> getLastUsed() async {
    LoggedAccounts loginData = await read();

    if (loginData.accounts.isEmpty || loginData.loggedInAccount == null) return null;
    final SafeAccount? safeAccount = loginData.loggedInAccount;
    return loginData.accounts.firstWhere((account) => SafeAccount.fromAccount(account) == safeAccount);
  }

  /// Finds user in [LoggedAccounts], returns null if a matching account isn't found.
  static Future<Account?> _findBySafeAccount(SafeAccount safeAccount) async {
    LoggedAccounts loginData = await read();
    for (Account account in loginData.accounts) {
      if (safeAccount.matches(account)) return account;
    }
    return null;
  }
}

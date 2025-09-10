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

  static Future<LoggedAccounts> write(LoggedAccounts loginData) async {
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
    await write(updatedData);
    return read();
  }

  static Future<LoggedAccounts> remove(Account account) async {
    LoggedAccounts loginData = await read();
    LoggedAccounts updatedData = LoggedAccounts(
      loggedInAccount: loginData.loggedInAccount!.matches(account) ? null : loginData.loggedInAccount,
      accounts: loginData.accounts..remove(account),
    );
    await write(updatedData);
    return await read();
  }

  static Future<LoggedAccounts> setCurrentlyUsed(Account? account) async {
    LoggedAccounts loginData = await read();
    LoggedAccounts updatedData = LoggedAccounts(
      loggedInAccount: account == null ? null : SafeAccount.fromAccount(account),
      accounts: loginData.accounts,
    );
    await write(updatedData);
    return await read();
  }
}

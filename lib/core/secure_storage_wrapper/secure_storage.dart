import 'dart:convert';

import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/core/types/freezed/account.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage keys for FlutterSecureStorage
class _SecureStorageKeys {
  static const String lastLogIn = 'last_log_in';
  static const String safeAccountList = 'safe_account_list';
  static String accountId(SafeAccount a) => 'psw_${a.username}_${a.url}';
}

class SecureStorage {
  static const AndroidOptions _androidOptions = AndroidOptions();
  static const IOSOptions _iosOptions = IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  static const FlutterSecureStorage instance = FlutterSecureStorage(aOptions: _androidOptions, iOptions: _iosOptions);

  static Future<String?> _read(String key) async {
    return await instance.read(key: key);
  }

  static Future<void> _save(String key, String data) async {
    await instance.write(key: key.toString(), value: data);
  }

  static Future<void> _remove(String key) async {
    await instance.delete(key: key);
  }

  static Future<void> saveLastLogIn(SafeAccount safeAccount) async {
    await _save(_SecureStorageKeys.lastLogIn, jsonEncode(safeAccount));
  }

  static Future<SafeAccount> readLastLogIn() async {
    String? val = await _read(_SecureStorageKeys.lastLogIn);
    if (val == null) throw AuthErrors.accountNotSelected;
    return SafeAccount.fromJson(jsonDecode(val));
  }

  static Future<void> removeLastLogIn() async {
    await _remove(_SecureStorageKeys.lastLogIn);
  }

  static Future<void> saveToAccountList(List<SafeAccount> safeAccounts) async {
    await _save(_SecureStorageKeys.safeAccountList, jsonEncode(safeAccounts));
  }

  static Future<List<SafeAccount>> readAccountList() async {
    String? val = await _read(_SecureStorageKeys.safeAccountList);
    if (val == null) throw AuthErrors.missingCredentials;
    final List<dynamic> decoded = jsonDecode(val);
    return decoded.map((json) => SafeAccount.fromJson(json)).toList();
  }

  static Future<bool> removeFromAccountList(SafeAccount safeAccount) async {
    final List<SafeAccount> safeAccounts = await readAccountList();
    final bool result = safeAccounts.remove(safeAccount);
    await _save(_SecureStorageKeys.safeAccountList, jsonEncode(safeAccounts));
    return result;
  }

  static Future<void> saveAccountPassword(Account account) async {
    await _save(_SecureStorageKeys.accountId(SafeAccount.fromAccount(account)), jsonEncode(account.password));
  }

  static Future<Account> readAccountPassword(SafeAccount account) async {
    String? val = await _read(_SecureStorageKeys.accountId(account));
    if (val == null) throw AuthErrors.accountNotFound;
    return Account.fromSafeAccount(account, jsonDecode(val));
  }

  static Future<void> removeAccountPassword(SafeAccount safeAccount) async {
    await _remove(_SecureStorageKeys.accountId(safeAccount));
  }
}

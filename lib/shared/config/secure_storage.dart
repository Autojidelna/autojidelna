import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const AndroidOptions _androidOptions = AndroidOptions(encryptedSharedPreferences: true);
  static const IOSOptions _iosOptions = IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  static FlutterSecureStorage instance = const FlutterSecureStorage(aOptions: _androidOptions, iOptions: _iosOptions);

  static final keys = _SecureStorageKeys();
}

/// Secure storage keys for FlutterSecureStorage
class _SecureStorageKeys {
  final String loginData = 'loginData';
  final String appleAuthKey = 'apple_auth_key';
}

import 'package:autojidelna/features/canteen/application/canteen.provider.dart';
import 'package:autojidelna/features/auth/data/auth_service.dart';
import 'package:autojidelna/core/types/freezed/account/account.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/core/types/freezed/user/user.dart';
import 'package:autojidelna/shared/providers/saved_accounts.dart';
import 'package:autojidelna/shared/services/credentials_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = ChangeNotifierProvider<UserProvider>((ref) => UserProvider(ref, AuthService(ref)));

class UserProvider extends ChangeNotifier {
  UserProvider(this._ref, this._authService);

  final AuthService _authService;
  final Ref _ref;

  User? _user;

  User? get user => _user;

  Future<void> login(Account account) async {
    final user = await _authService.login(account);
    if (user == null) return; // error
    _user = user;
    _ref.read(savedAccountsProvider.notifier).add(account);
    notifyListeners();
  }

  Future<void> logout(SafeAccount safeAccount) async {
    if (user == null) return;
    await _authService.logout(safeAccount);
    _ref.read(savedAccountsProvider.notifier).remove(safeAccount);
    if (_user!.accountData.username == safeAccount.username) {
      _user = null;
      _ref.read(canteenProvider).clear();
    }
    notifyListeners();
  }

  Future<void> loadUser() async {
    final user = await _authService.loginFromStorage();
    if (user == null) return;
    _user = user;
    notifyListeners();
  }

  Future<void> unloadUser() async {
    await CredentialsService.setLastUsed(null);
    _user = null;
    _ref.read(canteenProvider).clear();
    notifyListeners();
  }

  Future<void> changeUser(SafeAccount safeAccount) async {
    _user = null;
    _ref.read(canteenProvider).clear();
    await _authService.changeAccount(safeAccount);
    notifyListeners();
  }

  Future<void> updateUserData() async {
    if (_user == null) return;
    _user = _user!.copyWith(data: await _authService.fetchUserData(_user!.accountData.username));
    notifyListeners();
  }
}

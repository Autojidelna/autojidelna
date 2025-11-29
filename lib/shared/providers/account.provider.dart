import 'package:autojidelna/core/types/freezed/account/account.dart';
import 'package:autojidelna/core/types/freezed/safe_account/safe_account.dart';
import 'package:autojidelna/core/types/freezed/user/user.dart';
import 'package:autojidelna/features/auth/data/auth_service.dart';
import 'package:autojidelna/features/canteen/application/providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final userProvider = ChangeNotifierProvider<UserProvider>((ref) => UserProvider(ref, AuthService(ref)));

class UserProvider extends ChangeNotifier {
  UserProvider(this._ref, this._authService);

  final AuthService _authService;
  final Ref _ref;

  User? _user;
  List<SafeAccount> _loggedSafeAccounts = [];

  User? get user => _user;
  List<SafeAccount> get loggedInAccounts => _loggedSafeAccounts;

  Future<void> login(Account account) async {
    final user = await _authService.login(account);
    if (user == null) return; // error
    _user = user;
    _loggedSafeAccounts = await _authService.getLimitedAccounts();
    notifyListeners();
  }

  Future<void> logout(SafeAccount safeAccount) async {
    if (user == null) return;
    await _authService.logout(safeAccount);
    _loggedSafeAccounts = List.from(_loggedSafeAccounts)..remove(safeAccount);
    if (_user!.accountData.username == safeAccount.username) {
      _user = null;
      _ref.invalidate(denniNabidkaProvider);
    }
    notifyListeners();
  }

  Future<void> loadUser() async {
    final user = await _authService.loginFromStorage();
    if (user == null) return;
    _user = user;
    _loggedSafeAccounts = await _authService.getLimitedAccounts();
    notifyListeners();
  }

  Future<void> unloadUser() async {
    await _authService.ghostLogout();
    _user = null;
    _ref.invalidate(denniNabidkaProvider);
    notifyListeners();
  }

  Future<void> changeUser(SafeAccount safeAccount) async {
    _user = null;
    _ref.invalidate(denniNabidkaProvider);
    await _authService.changeAccount(safeAccount);
    notifyListeners();
  }

  Future<void> updateUserData() async {
    if (_user == null) return;
    _user = _user!.copyWith(data: await _authService.fetchUserData());
    notifyListeners();
  }

  Future<void> updateLoggedSafeAccounts() async {
    _loggedSafeAccounts = await _authService.getLimitedAccounts();
    notifyListeners();
  }
}

import 'package:autojidelna/core/types/freezed/account/account.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/shared/services/credentials_service.dart';
import 'package:autojidelna/features/auth/data/auth_service.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_accounts.g.dart';

@Riverpod(keepAlive: true)
class SavedAccounts extends _$SavedAccounts {
  @override
  Future<Set<SafeAccount>> build() async {
    return await CredentialsService.getSafeAccounts();
  }

  Future<void> add(Account account) async {
    await CredentialsService.save(account);
    final current = state.value ?? <SafeAccount>{};
    final updated = {...current}..add(SafeAccount.fromAccount(account));
    state = AsyncData(updated);
  }

  Future<void> remove(SafeAccount safeAccount) async {
    AuthService(ref).logout(safeAccount);
    final current = state.value ?? <SafeAccount>{};
    final updated = {...current}..remove(safeAccount);
    state = AsyncData(updated);
  }
}

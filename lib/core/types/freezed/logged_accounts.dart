import 'package:autojidelna/core/types/freezed/account.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'generated/logged_accounts.freezed.dart';
part 'generated/logged_accounts.g.dart';

@unfreezed
sealed class LoggedAccounts with _$LoggedAccounts {
  factory LoggedAccounts({
    @JsonKey(name: 'logged_in_account') SafeAccount? loggedInAccount,
    @JsonKey(name: 'accounts') @Default([]) List<Account> accounts,
  }) = _LoggedAccounts;

  factory LoggedAccounts.fromJson(Map<String, Object?> json) => _$LoggedAccountsFromJson(json);
}

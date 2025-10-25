import 'package:autojidelna/core/types/freezed/account/account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'safe_account.freezed.dart';
part 'safe_account.g.dart';

@freezed
sealed class SafeAccount with _$SafeAccount {
  const SafeAccount._();

  const factory SafeAccount({
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'url') required String url,
  }) = _SafeAccount;

  factory SafeAccount.fromJson(Map<String, Object?> json) => _$SafeAccountFromJson(json);

  static SafeAccount fromAccount(Account account) => SafeAccount(username: account.username, url: account.url);
  bool matches(Account account) => fromAccount(account) == this;
}

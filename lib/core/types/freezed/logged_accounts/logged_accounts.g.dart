// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_accounts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoggedAccounts _$LoggedAccountsFromJson(Map<String, dynamic> json) =>
    _LoggedAccounts(
      loggedInAccount: json['logged_in_account'] == null
          ? null
          : SafeAccount.fromJson(
              json['logged_in_account'] as Map<String, dynamic>),
      accounts: (json['accounts'] as List<dynamic>?)
              ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LoggedAccountsToJson(_LoggedAccounts instance) =>
    <String, dynamic>{
      'logged_in_account': instance.loggedInAccount?.toJson(),
      'accounts': instance.accounts.map((e) => e.toJson()).toList(),
    };

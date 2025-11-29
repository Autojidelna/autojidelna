import 'package:autojidelna/core/types/freezed/safe_account/safe_account.dart';
import 'package:icanteenlib/canteenlib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';

@freezed
sealed class User with _$User {
  const factory User({required SafeAccount accountData, required UzivatelskeUdaje? data}) = _User;
}

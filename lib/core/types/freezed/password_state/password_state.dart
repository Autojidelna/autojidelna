import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'password_state.freezed.dart';

@freezed
sealed class PasswordState with _$PasswordState {
  const factory PasswordState({
    String? errorText,
    @Default(false) bool isVisible,
  }) = _PasswordState;
}

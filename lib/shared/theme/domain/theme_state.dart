import 'package:autojidelna/shared/theme/domain/color_style.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/theme_state.freezed.dart';

@freezed
sealed class ThemeState with _$ThemeState {
  const ThemeState._();

  const factory ThemeState({required ThemeStyle themeStyle, required ThemeMode themeMode, required bool amoledMode}) = _ThemeState;
}

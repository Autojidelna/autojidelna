import 'dart:async';

import 'package:autojidelna/src/_conf/hive.dart';
import 'package:autojidelna/src/types/freezed/theme_state/theme_state.dart';
import 'package:autojidelna/src/types/theme.dart';
import 'package:autojidelna/src/ui/theme/app_themes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'theme.riverpod.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  late final Box _box;

  @override
  ThemeState build() {
    _box = Hive.box(Boxes.settings);
    return ThemeState(
      themeStyle: _box.get(HiveKeys.settings.themeStyle, defaultValue: ThemeStyle.defaultStyle),
      themeMode: _box.get(HiveKeys.settings.themeMode, defaultValue: ThemeMode.system),
      amoledMode: _box.get(HiveKeys.settings.amoledMode, defaultValue: false),
    );
  }

  void setThemeStyle(ThemeStyle themeStyle) {
    if (state.themeStyle == themeStyle) return;
    state = state.copyWith(themeStyle: themeStyle);
    unawaited(_box.put(HiveKeys.settings.themeStyle, themeStyle));
  }

  void setThemeMode(ThemeMode themeMode) {
    state = state.copyWith(themeMode: themeMode);
    unawaited(_box.put(HiveKeys.settings.themeMode, themeMode));
  }

  void setAmoledMode(bool isPureBlack) {
    state = state.copyWith(amoledMode: isPureBlack);
    unawaited(_box.put(HiveKeys.settings.amoledMode, isPureBlack));
  }

  ColorScheme colorSchemeLight([ThemeStyle? themeStyle]) {
    ColorStyle colorStyle = AppThemes.colorStyles[themeStyle ?? state.themeStyle]!;

    return AppThemes.colorSchemeLight.copyWith(
      primary: colorStyle.primaryLight,
      secondary: colorStyle.secondaryLight,
    );
  }

  ColorScheme colorSchemeDark([ThemeStyle? themeStyle]) {
    ColorStyle colorStyle = AppThemes.colorStyles[themeStyle ?? state.themeStyle]!;

    return AppThemes.colorSchemeDark.copyWith(
      primary: colorStyle.primaryDark,
      secondary: colorStyle.secondaryDark,
      surface: state.amoledMode ? Colors.black : const Color(0xff121212),
      scrim: state.amoledMode ? Colors.black87 : Colors.black54,
    );
  }

  bool isBright(Brightness platformBrightness) =>
      (state.themeMode == ThemeMode.system && platformBrightness == Brightness.light) || state.themeMode == ThemeMode.light;
}

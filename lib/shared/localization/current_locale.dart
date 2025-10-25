import 'dart:async';
import 'dart:ui';

import 'package:autojidelna/shared/config/hive.dart';
import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_locale.g.dart';

@Riverpod(keepAlive: true)
class CurrentLocale extends _$CurrentLocale {
  final Box _box = Hive.box(Boxes.appState);

  @override
  Locale build() => _box.get(HiveKeys.appState.locale, defaultValue: const Locale('cs'));

  void update(Locale newLocale) {
    state = newLocale;
    unawaited(_box.put(HiveKeys.appState.locale, newLocale));
  }
}

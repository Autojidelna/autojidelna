import 'dart:async';

import 'package:autojidelna/src/_conf/hive.dart';
import 'package:autojidelna/src/types/theme.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings.riverpod.g.dart';

final _box = Hive.box(Boxes.settings);

@riverpod
class ListUiNotifier extends _$ListUiNotifier {
  @override
  bool build() => _box.get(HiveKeys.settings.listUi, defaultValue: false);

  void update(bool enabled) {
    state = enabled;
    unawaited(_box.put(HiveKeys.settings.listUi, state));
  }
}

@riverpod
class BigCalendarMarkersNotifier extends _$BigCalendarMarkersNotifier {
  @override
  bool build() => _box.get(HiveKeys.settings.bigCalendarMarkers, defaultValue: false);

  void update(bool enabled) {
    state = enabled;
    unawaited(_box.put(HiveKeys.settings.bigCalendarMarkers, state));
  }
}

@riverpod
class SkipWeekendsNotifier extends _$SkipWeekendsNotifier {
  @override
  bool build() => _box.get(HiveKeys.settings.skipWeekends, defaultValue: false);

  void update(bool enabled) {
    state = enabled;
    unawaited(_box.put(HiveKeys.settings.skipWeekends, state));
  }
}

@riverpod
class RelativeTimeStampsNotifier extends _$RelativeTimeStampsNotifier {
  @override
  bool build() => _box.get(HiveKeys.settings.relTimeStamps, defaultValue: false);

  void update(bool enabled) {
    state = enabled;
    unawaited(_box.put(HiveKeys.settings.relTimeStamps, state));
  }
}

@riverpod
class DateFormatOptionsNotifier extends _$DateFormatOptionsNotifier {
  @override
  DateFormatOptions build() => _box.get(HiveKeys.settings.dateFormat, defaultValue: DateFormatOptions.dMy);

  void update(DateFormatOptions dateFormat) {
    state = dateFormat;
    unawaited(_box.put(HiveKeys.settings.dateFormat, state));
  }
}

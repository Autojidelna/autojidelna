import 'dart:async';

import 'package:autojidelna/core/analytics/analytics_service.dart';
import 'package:autojidelna/core/crashlytics/crashlytics_service.dart';
import 'package:autojidelna/shared/config/hive.dart';

import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_notifiers.g.dart';

final _box = Hive.box(Boxes.analytics);

@riverpod
class AllowAnalytics extends _$AllowAnalytics {
  @override
  bool build() => _box.get(HiveKeys.analytics.allowAnalytics, defaultValue: false);

  void update(bool enabled) {
    state = enabled;
    AnalyticsService.enabled(state);
    unawaited(_box.put(HiveKeys.analytics.allowAnalytics, state));
  }
}

@riverpod
class SendCrashLogs extends _$SendCrashLogs {
  @override
  bool build() => _box.get(HiveKeys.analytics.sendCrashLogs, defaultValue: false);

  void update(bool enabled) {
    state = enabled;
    CrashlyticsService.enabled(state);
    unawaited(_box.put(HiveKeys.analytics.sendCrashLogs, state));
  }
}

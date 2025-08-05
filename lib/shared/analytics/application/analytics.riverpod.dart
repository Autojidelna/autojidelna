// TODO: implement analytics

import 'dart:async';

import 'package:autojidelna/shared/config/hive.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics.riverpod.g.dart';

final _box = Hive.box(Boxes.analytics);

@riverpod
class AllowAnalyticsNotifier extends _$AllowAnalyticsNotifier {
  @override
  bool build() => _box.get(HiveKeys.analytics.allowAnalytics, defaultValue: false);

  void update(bool enabled) {
    state = enabled;
    unawaited(_box.put(HiveKeys.analytics.allowAnalytics, state));
  }
}

@riverpod
class SendCrashLogsNotifier extends _$SendCrashLogsNotifier {
  @override
  bool build() => _box.get(HiveKeys.analytics.sendCrashLogs, defaultValue: false);

  void update(bool enabled) {
    state = enabled;
    unawaited(_box.put(HiveKeys.analytics.sendCrashLogs, state));
  }
}

import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsService {
  static void enabled(bool enabled) {
    unawaited(FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(enabled));
    if (!enabled) unawaited(FirebaseCrashlytics.instance.deleteUnsentReports());
  }
}

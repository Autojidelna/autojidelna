import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsService {
  static void enabled(bool enabled) async {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(enabled);
    if (!enabled) FirebaseCrashlytics.instance.deleteUnsentReports();
  }

  static void error(dynamic e, StackTrace st) async {
    FirebaseCrashlytics.instance.recordError(e, st);
  }
}

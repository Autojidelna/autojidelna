import 'dart:async';

import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/app/app_providers.dart';
import 'package:autojidelna/core/analytics/analytics_service.dart';
import 'package:autojidelna/core/crashlytics/crashlytics_service.dart';
import 'package:autojidelna/shared/config/adapters.hive.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class AppInit {
  static bool _hiveExecuted = false;
  static bool _firebaseCrashlyticsExecuted = false;
  static bool _firebaseAnalyticsExecuted = false;
  static bool _remoteConfigExecuted = false;
  static bool _secureStorageExecuted = false;
  static bool _packageInfoExecuted = false;
  static bool _rotationExecuted = false;
  static bool _codePushExecuted = false;
  //static bool _initNotificationsExecuted = false;

  static Future<void> hive() async {
    assert(_hiveExecuted == false, 'AppInit.hive() must be called only once');
    if (_hiveExecuted) return;

    await Hive.initFlutter();
    Hive.registerAdapter(ThemeModeAdapter());
    Hive.registerAdapter(ThemeStyleAdapter());
    Hive.registerAdapter(DateFormatOptionsAdapter());
    Hive.registerAdapter(LocaleAdapter());
    await Hive.openBox(Boxes.settings);
    await Hive.openBox(Boxes.appState);
    await Hive.openBox(Boxes.analytics);
    await Hive.openBox(Boxes.notifications);

    _hiveExecuted = true;
  }

  static Future<void> firebaseCrashlytics() async {
    assert(_firebaseCrashlyticsExecuted == false, 'AppInit.firebaseCrashlytics() must be called only once');
    if (_firebaseCrashlyticsExecuted) return;

    final box = Hive.box(Boxes.analytics);
    bool sendCrashLogs = box.get(HiveKeys.analytics.sendCrashLogs, defaultValue: false);
    CrashlyticsService.enabled(sendCrashLogs);
    box.put(HiveKeys.analytics.sendCrashLogs, sendCrashLogs);

    // We don't want to send crash reports while in development. Web is not supported yet by Crashlytics.
    if (!kIsWeb && kReleaseMode && sendCrashLogs) {
      // Flutter error handling
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        unawaited(FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
        return true;
      };
    }

    _firebaseCrashlyticsExecuted = true;
  }

  static Future<void> firebaseAnalytics() async {
    assert(_firebaseAnalyticsExecuted == false, 'AppInit.firebaseCrashlytics() must be called only once');
    if (_firebaseAnalyticsExecuted) return;

    final box = Hive.box(Boxes.analytics);
    bool allowAnalytics = box.get(HiveKeys.analytics.allowAnalytics, defaultValue: false);
    AnalyticsService.enabled(allowAnalytics);
    box.put(HiveKeys.analytics.allowAnalytics, allowAnalytics);

    _firebaseAnalyticsExecuted = true;
  }

  static Future<void> remoteConfig() async {
    assert(_remoteConfigExecuted == false, 'AppInit.remoteConfig() must be called only once');
    if (_remoteConfigExecuted) return;

    //TODO: make initRemoteConfig work
    //await remoteConfigProvider.init();
    //App.initProviderOverrides.add(remoteConfigProvider.overrideWithValue(Rmc()));

    _remoteConfigExecuted = true;
  }

  static Future<void> secureStorage() async {
    assert(_secureStorageExecuted == false, 'AppInit.secureStorage() must be called only once');
    if (_secureStorageExecuted) return;

    AndroidOptions android = const AndroidOptions(encryptedSharedPreferences: true);
    FlutterSecureStorage secureStorage = FlutterSecureStorage(aOptions: android);

    App.initProviderOverrides.add(secureStorageProvider.overrideWithValue(secureStorage));
    _secureStorageExecuted = true;
  }

  static Future<void> packageInfo() async {
    assert(_packageInfoExecuted == false, 'AppInit.packageInfo() must be called only once');
    if (_packageInfoExecuted) return;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    App.initProviderOverrides.add(packageInfoProvider.overrideWithValue(packageInfo));
    _packageInfoExecuted = true;
  }

  static Future<void> rotation() async {
    assert(_rotationExecuted == false, 'AppInit.rotation() must be called only once');
    if (_rotationExecuted) return;

    SystemChrome.setPreferredOrientations(App.defaultRotations);
    _rotationExecuted = true;
  }

  static Future<void> codePush() async {
    assert(_codePushExecuted == false, 'AppInit.codePush() must be called only once');
    if (_codePushExecuted) return;

    int? currentPatchNumber = await ShorebirdCodePush().currentPatchNumber();
    if (!kIsWeb && kReleaseMode) {
      FirebaseCrashlytics.instance.setCustomKey(
        'shorebird_patch_number',
        '$currentPatchNumber',
      );
    }
    App.initProviderOverrides.add(currentPatchNumberProvider.overrideWithValue(currentPatchNumber));
    _codePushExecuted = true;
  }
}

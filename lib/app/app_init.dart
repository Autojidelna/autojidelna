import 'dart:ui';

import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/app/app_providers.dart';
import 'package:autojidelna/shared/config/adapters.hive.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/src/_global/providers/remote_config.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class AppInit {
  static bool _initHiveExecuted = false;
  static bool _initRemoteConfigExecuted = false;
  static bool _initLocalizationExecuted = false;
  static bool _initSecureStorageExecuted = false;
  static bool _initPlatformExecuted = false;
  static bool _initRotationExecuted = false;
  static bool _initCodePushExecuted = false;
  //static bool _initNotificationsExecuted = false;

  static Future<void> initHive() async {
    assert(_initHiveExecuted == false, 'AppInit.initHive() must be called only once');
    if (_initHiveExecuted) return;

    await Hive.initFlutter();
    Hive.registerAdapter(ThemeModeAdapter());
    Hive.registerAdapter(ThemeStyleAdapter());
    Hive.registerAdapter(DateFormatOptionsAdapter());
    await Hive.openBox(Boxes.settings);
    await Hive.openBox(Boxes.appState);
    await Hive.openBox(Boxes.analytics);
    await Hive.openBox(Boxes.notifications);

    _initHiveExecuted = true;
  }

  static Future<void> initRemoteConfig() async {
    assert(_initRemoteConfigExecuted == false, 'AppInit.initRemoteConfig() must be called only once');
    if (_initRemoteConfigExecuted) return;

    //TODO: make initRemoteConfig work
    //await remoteConfigProvider.init();
    App.initProviderOverrides.add(remoteConfigProvider.overrideWithValue(Rmc()));

    _initRemoteConfigExecuted = true;
  }

  static Future<void> initLocalization() async {
    assert(_initLocalizationExecuted == false, 'AppInit.initLocalization() must be called only once');
    if (_initLocalizationExecuted) return;

    final Box box = Hive.box(Boxes.appState);
    String locale = box.get(HiveKeys.appState.locale, defaultValue: const Locale('cs'));
    box.put(HiveKeys.appState.locale, locale);

    _initLocalizationExecuted = true;
  }

  static Future<void> initSecureStorage() async {
    assert(_initSecureStorageExecuted == false, 'AppInit.initSecureStorage() must be called only once');
    if (_initSecureStorageExecuted) return;

    AndroidOptions android = const AndroidOptions(encryptedSharedPreferences: true);
    FlutterSecureStorage secureStorage = FlutterSecureStorage(aOptions: android);

    App.initProviderOverrides.add(secureStorageProvider.overrideWithValue(secureStorage));
    _initSecureStorageExecuted = true;
  }

  static Future<void> initPlatform() async {
    assert(_initPlatformExecuted == false, 'AppInit.initPlatform() must be called only once');
    if (_initPlatformExecuted) return;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    App.initProviderOverrides.add(packageInfoProvider.overrideWithValue(packageInfo));
    _initPlatformExecuted = true;
  }

  static Future<void> initRotation() async {
    assert(_initRotationExecuted == false, 'AppInit.initRemoteConfig() must be called only once');
    if (_initRotationExecuted) return;

    SystemChrome.setPreferredOrientations(App.defaultRotations);
    _initRotationExecuted = true;
  }

  static Future<void> initCodePush() async {
    assert(_initCodePushExecuted == false, 'AppInit.initCodePush() must be called only once');
    if (_initCodePushExecuted) return;

    int? currentPatchNumber = await ShorebirdCodePush().currentPatchNumber();
    if (!kDebugMode) {
      Sentry.configureScope((scope) async {
        scope.setTag('shorebird_patch_number', '$currentPatchNumber');
      });
    }
    if (!kDebugMode && !kProfileMode && !kIsWeb) {
      FirebaseCrashlytics.instance.setCustomKey(
        'shorebird_patch_number',
        '$currentPatchNumber',
      );
    }
    App.initProviderOverrides.add(currentPatchNumberProvider.overrideWithValue(currentPatchNumber));
    _initCodePushExecuted = true;
  }
}

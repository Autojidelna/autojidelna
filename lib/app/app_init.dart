import 'dart:async';
import 'dart:convert';

import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/core/analytics/analytics_service.dart';
import 'package:autojidelna/core/crashlytics/crashlytics_service.dart';
import 'package:autojidelna/core/notifications/notification_topics.dart';
import 'package:autojidelna/core/notifications/notification_handler.dart';
import 'package:autojidelna/core/notifications/notification_channel_service.dart';
import 'package:autojidelna/core/remote-config/remote_config.dart';
import 'package:autojidelna/shared/config/adapters.hive.dart';
import 'package:autojidelna/shared/config/hive.dart';

import 'package:flutter/foundation.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:awesome_notifications/awesome_notifications.dart' hide NotificationHandler;

class AppInit {
  static bool _hiveExecuted = false;
  static bool _firebaseCrashlyticsExecuted = false;
  static bool _firebaseAnalyticsExecuted = false;
  static bool _firebaseRemoteConfigExecuted = false;
  static bool _firebaseMessagingExecuted = false;
  static bool _awesomeNotificationsExecuted = false;

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
    AnalyticsService.instance.enabled(allowAnalytics);
    box.put(HiveKeys.analytics.allowAnalytics, allowAnalytics);

    _firebaseAnalyticsExecuted = true;
  }

  static Future<void> firebaseRemoteConfig() async {
    assert(_firebaseRemoteConfigExecuted == false, 'AppInit.firebaseRemoteConfig() must be called only once');
    if (_firebaseRemoteConfigExecuted) return;

    final remoteConfig = RemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(days: 7),
      ),
    );

    // Load defaults from local storage (Hive)
    final savedDefaults = Hive.box(Boxes.appState).get(
      HiveKeys.appState.remoteConfigValues,
      defaultValue: RemoteConfig.defaultValues[RemoteConfig.canteenUrls],
    );

    if (savedDefaults != null) {
      // Ensure only supported types go into setDefaults()
      final safeDefaults = savedDefaults.map((key, value) {
        if (value is Map || value is List) {
          return MapEntry(key, jsonEncode(value));
        }
        return MapEntry(key, value);
      }).cast<String, dynamic>();

      await remoteConfig.setDefaults(safeDefaults);
    }

    try {
      await remoteConfig.fetchAndActivate();
      final fetchedValues = remoteConfig.getAll();
      final parsedValues = RemoteConfig.parseRemoteConfigValues(fetchedValues);
      await Hive.box(Boxes.appState).put(HiveKeys.appState.remoteConfigValues, parsedValues);
      App.initProviderOverrides.add(remoteConfigValues.overrideWithValue(parsedValues));
    } catch (_) {}

    _firebaseRemoteConfigExecuted = true;
  }

  static Future<void> firebaseMessaging() async {
    assert(_firebaseMessagingExecuted == false, 'AppInit.firebaseMessaging() must be called only once');
    if (_firebaseMessagingExecuted) return;

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Foreground messages
    FirebaseMessaging.onMessage.listen(NotificationHandler.handleIncomingMessage);

    // When notification is tapped & app opens
    FirebaseMessaging.onMessageOpenedApp.listen(NotificationHandler.handleIncomingMessage);

    for (String topic in NotificationTopics.all) {
      FirebaseMessaging.instance.subscribeToTopic(topic);
    }

    _firebaseMessagingExecuted = true;
  }

  static Future<void> awesomeNotifications() async {
    assert(_awesomeNotificationsExecuted == false, 'AppInit.awesomeNotifications() must be called only once');
    if (_awesomeNotificationsExecuted) return;

    await AwesomeNotifications().initialize(
      'resource://drawable/ic_launcher',
      [
        NotificationChannel(
          channelKey: 'default',
          channelName: 'Default',
          channelDescription: 'Default',
          importance: NotificationImportance.High,
        ),
      ],
      channelGroups: NotificationChannelService.channelGroups,
      debug: kDebugMode,
    );

    _awesomeNotificationsExecuted = true;
  }
}

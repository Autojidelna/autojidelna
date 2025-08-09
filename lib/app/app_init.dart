import 'dart:async';

import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/app/app_providers.dart';
import 'package:autojidelna/core/analytics/analytics_service.dart';
import 'package:autojidelna/core/crashlytics/crashlytics_service.dart';
import 'package:autojidelna/core/notifications/notification_topics.dart';
import 'package:autojidelna/core/notifications/notification_handler.dart';
import 'package:autojidelna/core/notifications/notification_channel_service.dart';
import 'package:autojidelna/shared/config/adapters.hive.dart';
import 'package:autojidelna/shared/config/hive.dart';

import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:awesome_notifications/awesome_notifications.dart' hide NotificationHandler;

class AppInit {
  static bool _hiveExecuted = false;
  static bool _firebaseCrashlyticsExecuted = false;
  static bool _firebaseAnalyticsExecuted = false;
  static bool _firebaseMessagingExecuted = false;
  static bool _awesomeNotificationsExecuted = false;
  static bool _codePushExecuted = false;

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

  static Future<void> codePush() async {
    assert(_codePushExecuted == false, 'AppInit.codePush() must be called only once');
    if (_codePushExecuted) return;

    int? currentPatchNumber = (await ShorebirdUpdater().readCurrentPatch())?.number;
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

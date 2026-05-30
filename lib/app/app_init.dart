import 'dart:async';

import 'package:autojidelna/core/notifications/notification_channel_service.dart';
import 'package:autojidelna/shared/config/adapters.hive.dart';
import 'package:autojidelna/shared/config/hive.dart';

import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:awesome_notifications/awesome_notifications.dart' hide NotificationHandler;

class AppInit {
  static bool _hiveExecuted = false;
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

  static Future<void> awesomeNotifications() async {
    assert(_awesomeNotificationsExecuted == false, 'AppInit.awesomeNotifications() must be called only once');
    if (_awesomeNotificationsExecuted) return;

    await AwesomeNotifications().initialize(
      'resource://drawable/ic_launcher',
      [NotificationChannel(channelKey: 'default', channelName: 'Default', channelDescription: 'Default', importance: NotificationImportance.High)],
      channelGroups: NotificationChannelService.channelGroups,
      debug: kDebugMode,
    );

    _awesomeNotificationsExecuted = true;
  }
}

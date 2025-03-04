import 'package:autojidelna/src/_conf/notifications.dart';
import 'package:autojidelna/src/lang/l10n_context_extension.dart';
import 'package:autojidelna/src/lang/supported_locales.dart';
import 'package:autojidelna/src/logic/services/auth_service.dart';
import 'package:autojidelna/src/types/freezed/safe_account.dart/safe_account.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final Texts _lang = lookupTexts(Locales.cs);

  void removeNotifications(SafeAccount account) async {
    final AwesomeNotifications notifs = AwesomeNotifications();
    notifs.removeChannel(NotificationIds.dnesniJidloChannel(account));
    notifs.removeChannel(NotificationIds.objednanoChannel(account));
    notifs.removeChannel(NotificationIds.kreditChannel(account));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    await BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 120,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          startOnBoot: true,
          requiredNetworkType: NetworkType.ANY,
        ), (String taskId) async {
      // <-- Event handler
      // This is the fetch-event callback.
      if (kDebugMode) print('[BackgroundFetch] Event received $taskId');

      // IMPORTANT:  You must signal completion of your task or the OS can punish your app
      // for taking too long in the background.
      // TODO: await doNotifications();
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      // <-- Task timeout handler.
      // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
      if (kDebugMode) print('[BackgroundFetch] TASK TIMEOUT taskId: $taskId');
      BackgroundFetch.finish(taskId);
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  Future<bool> initAwesome() async {
    List<SafeAccount> limitedAccounts = await AuthService().getLimitedAccounts();

    // Generate notification channel groups
    List<NotificationChannelGroup> notificationChannelGroups = [
      ...limitedAccounts.expand((account) => _createNotificationChannelGroups(account)),
      NotificationChannelGroup(
        channelGroupKey: NotificationIds.channelGroupElse,
        channelGroupName: _lang.notificationOther,
      ),
    ];

    // Generate notification channels
    List<NotificationChannel> notificationChannels = [
      ...limitedAccounts.expand((account) => _createNotificationChannels(account)),
      NotificationChannel(
        channelGroupKey: NotificationIds.channelGroupElse,
        channelKey: NotificationIds.channelElse,
        channelName: _lang.notificationOther,
        channelDescription: _lang.notificationOtherDescription,
        importance: NotificationImportance.Min,
        playSound: false,
      ),
    ];

    return await AwesomeNotifications().initialize(
      null, // Use default app icon
      notificationChannels,
      channelGroups: notificationChannelGroups,
      debug: false,
    );
  }

  List<NotificationChannelGroup> _createNotificationChannelGroups(SafeAccount account) {
    return [_createChannelGroup(NotificationIds.channelGroup(account), _lang.notificationsFor(account.username))];
  }

  List<NotificationChannel> _createNotificationChannels(SafeAccount account) {
    return [
      _createChannel(
        NotificationIds.channelGroup(account),
        NotificationIds.dnesniJidloChannel(account),
        _lang.channelNameDish,
        _lang.channelDescriptionDish(account.username),
      ),
      _createChannel(
        NotificationIds.channelGroup(account),
        NotificationIds.kreditChannel(account),
        _lang.channelNameLowCredit,
        _lang.channelDescriptionLowCredit(account.username),
      ),
      _createChannel(
        NotificationIds.channelGroup(account),
        NotificationIds.objednanoChannel(account),
        _lang.channelNameOrdered,
        _lang.channelDescriptionOrdered(account.username),
      ),
    ];
  }

  NotificationChannelGroup _createChannelGroup(String key, String name) {
    return NotificationChannelGroup(channelGroupKey: key, channelGroupName: name);
  }

  NotificationChannel _createChannel(String groupKey, String key, String name, String description) {
    return NotificationChannel(
      channelShowBadge: true,
      channelGroupKey: groupKey,
      channelKey: key,
      channelName: name,
      channelDescription: description,
      defaultColor: const Color(0xFF9D50DD),
      ledColor: Colors.white,
    );
  }
}

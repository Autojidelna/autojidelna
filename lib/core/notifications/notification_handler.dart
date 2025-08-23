import 'dart:convert';

import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/core/notifications/notification_channel_service.dart';
import 'package:autojidelna/core/notifications/notification_topics.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/core/types/freezed/logged_accounts/logged_accounts.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/core/utils/url.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/config/secure_storage.dart';
import 'package:autojidelna/shared/localization/current_locale.dart';
import 'package:autojidelna/shared/utils/datetime_utils.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:canteenlib/canteenlib.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await App.backgroundInit();
  //NotificationHandler.placeholderNotification(message.data['type']);
  NotificationHandler.handleIncomingMessage(message);
}

class NotificationHandler {
  static void handleIncomingMessage(RemoteMessage message) async => _runTopicAction(message.data['type']);

  static void _runTopicAction(String? topic) {
    if (topic == null) return;

    final actions = <String, Function>{
      NotificationTopics.foodToday: _foodToday,
      NotificationTopics.lowCredit: _lowCredit,
      NotificationTopics.nextWeekFoodCheck: _nextWeekFoodCheck,
    };

    actions[topic]?.call(topic);
  }

  static void placeholderNotification(String topic) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: topic.hashCode,
        channelKey: 'default',
        title: 'Test notification',
        body: 'Topic recieved: $topic',
        criticalAlert: true,
      ),
    );
  }

  static Future<void> _foodToday(String topic) async {
    final l10n = lookupL10n(App.globalContainer.read(currentLocaleProvider));
    final now = DateTime.now();
    final limitedAccounts = await _getLimitedAccountsFromStorage();

    for (var i = 0; i < limitedAccounts.length; i++) {
      final safeAccount = limitedAccounts[i];

      try {
        final canteen = await _loginBySafeAccount(safeAccount);
        final menu = await _getDailyMenu(canteen, now);

        if (menu == null || menu.jidla.isEmpty) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1024 - i,
              channelKey: NotificationChannelService.getChannelKey(NotificationChannelService.userIdGen(safeAccount), topic),
              groupKey: NotificationChannelService.userIdGen(safeAccount),
              summary: safeAccount.username,
              title: l10n.notificationFoodTodayNoTitle,
              body: l10n.notificationFoodTodayNoDescription,
            ),
          );
          continue;
        }

        for (var k = 0; k < menu.jidla.length; k++) {
          if (!menu.jidla[k].objednano) continue;
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1024 - i,
              channelKey: NotificationChannelService.getChannelKey(NotificationChannelService.userIdGen(safeAccount), topic),
              groupKey: NotificationChannelService.userIdGen(safeAccount),
              summary: safeAccount.username,
              title: l10n.notificationFoodTodayYesTitle,
              body: menu.jidla[k].kategorizovano?.hlavniJidlo ?? menu.jidla[k].nazev,
            ),
          );
          break;
        }
      } catch (e) {
        if (kDebugMode) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 10,
              channelKey: NotificationChannelService.defaultChannelKey,
              title: l10n.debugFailedNotification(topic),
              body: e.toString(),
            ),
          );
        }
      }
    }
  }

  static void _lowCredit(String topic) async {
    final l10n = lookupL10n(App.globalContainer.read(currentLocaleProvider));
    final limitedAccounts = await _getLimitedAccountsFromStorage();

    for (var i = 0; i < limitedAccounts.length; i++) {
      final safeAccount = limitedAccounts[i];

      try {
        final canteen = await _loginBySafeAccount(safeAccount);
        final user = await canteen.ziskejUzivatele();

        if (user.kredit < 500) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 512 - i,
              channelKey: NotificationChannelService.getChannelKey(NotificationChannelService.userIdGen(safeAccount), topic),
              groupKey: NotificationChannelService.userIdGen(safeAccount),
              summary: safeAccount.username,
              title: l10n.notificationLowCreditTitle,
              body: l10n.notificationLowCreditDescription,
            ),
          );
          continue;
        }
      } catch (e) {
        if (kDebugMode) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 10,
              channelKey: NotificationChannelService.defaultChannelKey,
              title: l10n.debugFailedNotification(topic),
              body: e.toString(),
            ),
          );
        }
      }
    }
  }

  static void _nextWeekFoodCheck(String topic) async {
    final l10n = lookupL10n(App.globalContainer.read(currentLocaleProvider));
    DateTime now = DateTime.now();
    final limitedAccounts = await _getLimitedAccountsFromStorage();

    for (var i = 0; i < limitedAccounts.length; i++) {
      final safeAccount = limitedAccounts[i];

      try {
        final canteen = await _loginBySafeAccount(safeAccount);
        int orderedDays = 0;

        for (var i = 0; i < 7; i++) {
          now = now.add(const Duration(days: 1));
          final menu = await _getDailyMenu(canteen, now);
          if (menu == null || menu.jidla.isEmpty) continue;
          for (var k = 0; k < menu.jidla.length; k++) {
            if (!menu.jidla[k].objednano) continue;
            orderedDays++;
            break;
          }
        }

        if (orderedDays < 3) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 256 - i,
              channelKey: NotificationChannelService.getChannelKey(NotificationChannelService.userIdGen(safeAccount), topic),
              title: l10n.notificationNextWeekFoodCheckTitle,
              body: l10n.notificationNextWeekFoodCheckDescription,
            ),
          );
          continue;
        }
      } catch (e) {
        if (kDebugMode) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 10,
              channelKey: NotificationChannelService.defaultChannelKey,
              title: l10n.debugFailedNotification(topic),
              body: e.toString(),
            ),
          );
        }
      }
    }
  }

  static Future<List<SafeAccount>> _getLimitedAccountsFromStorage() async {
    const secureStorage = SecureStorage.instance;
    final value = await secureStorage.read(key: SecureStorage.keys.loginData);
    if (value == null || value.trim().isEmpty) return [];
    final data = LoggedAccounts.fromJson(jsonDecode(value));
    return data.accounts.map(SafeAccount.fromAccount).toList();
  }

  static Future<Canteen> _loginBySafeAccount(SafeAccount safeAccount) async {
    const secureStorage = SecureStorage.instance;
    final value = await secureStorage.read(key: SecureStorage.keys.loginData);
    if (value == null || value.trim().isEmpty) throw AuthErrors.accountNotFound;

    final data = LoggedAccounts.fromJson(jsonDecode(value));
    final account = data.accounts.firstWhere(
      (acc) => safeAccount.matches(acc),
      orElse: () => throw AuthErrors.accountNotFound,
    );

    var url = Url.clean(account.url);
    var canteen = Canteen(url);
    try {
      if (!await canteen.login(account.username, account.password)) {
        throw AuthErrors.wrongCredentials;
      }
    } catch (_) {
      url = account.url;
      canteen = Canteen(url);
      if (!await canteen.login(account.username, account.password)) {
        throw AuthErrors.wrongCredentials;
      }
    }
    return canteen;
  }

  static Future<Jidelnicek?> _getDailyMenu(Canteen canteen, DateTime date) async {
    if (!await InternetConnectionChecker.instance.hasConnection) {
      throw CanteenErrors.noInternetConnection;
    }
    try {
      return await canteen.jidelnicekDen(den: date.normalize);
    } catch (e) {
      if (!await InternetConnectionChecker.instance.hasConnection) {
        throw CanteenErrors.noInternetConnection;
      }
      if (e == CanteenLibExceptions.jePotrebaSePrihlasit) {
        throw CanteenErrors.needToLogin;
      }
      if (e == CanteenLibExceptions.featureNepodporovana) {
        throw CanteenErrors.unsuportedFeature;
      }
      rethrow;
    }
  }
}

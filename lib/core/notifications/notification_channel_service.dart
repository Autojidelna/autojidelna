import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/core/notifications/notification_topics.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/core/utils/url.dart';
import 'package:autojidelna/l10n/output/l10n.dart';
import 'package:autojidelna/shared/localization/current_locale.dart';

import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationChannelService {
  static final L10n _l10n = lookupL10n(App.globalContainer.read(currentLocaleProvider));

  static String userIdGen(SafeAccount account) => '${Url.clean(account.url)}-${account.username}';
  static String getChannelKey(String userId, String topic) => '$userId-$topic';
  static String getGroup(String topic) => 'group-$topic';

  Future<void> createChannelsForUser(SafeAccount account) async {
    String userId = userIdGen(account);
    for (final topic in NotificationTopics.all) {
      final channelKey = getChannelKey(userId, topic);
      final channelGroupKey = getGroup(topic);

      await AwesomeNotifications().setChannel(
        NotificationChannel(
          channelKey: channelKey,
          channelName: account.username,
          channelDescription: _channelDescriptions[topic],
          channelGroupKey: channelGroupKey,
          importance: NotificationImportance.High,
        ),
      );
    }
  }

  Future<void> removeChannelsForUser(SafeAccount account) async {
    String userId = userIdGen(account);
    for (final topic in NotificationTopics.all) {
      await AwesomeNotifications().removeChannel(getChannelKey(userId, topic));
    }
  }

  static final Map<String, String> _channelDescriptions = {
    'food_today_1100': _l10n.notificationFoodTodayDescription,
    'low_credit_1500': _l10n.notificationLowCreditDescription,
    'next_week_food_check_1500': _l10n.notificationNextWeekFoodCheckDescription,
  };

  static List<NotificationChannelGroup> channelGroups = [
    NotificationChannelGroup(channelGroupKey: getGroup(NotificationTopics.foodToday), channelGroupName: _l10n.channelNameDish),
    NotificationChannelGroup(channelGroupKey: getGroup(NotificationTopics.lowCredit), channelGroupName: _l10n.channelNameLowCredit),
    NotificationChannelGroup(channelGroupKey: getGroup(NotificationTopics.nextWeekFoodCheck), channelGroupName: _l10n.channelNameOrdered),
  ];
}

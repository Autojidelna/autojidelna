import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/core/notifications/notification_topics.dart';
import 'package:autojidelna/core/types/freezed/safe_account/safe_account.dart';
import 'package:autojidelna/core/utils/url.dart';
import 'package:autojidelna/l10n/output/l10n.dart';
import 'package:autojidelna/shared/localization/current_locale.dart';

import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationChannelService {
  static final L10n _l10n = lookupL10n(App.globalContainer.read(currentLocaleProvider));

  static String userIdGen(SafeAccount account) => '${Url.clean(account.url)}-${account.username}';
  static String getChannelKey(String userId, String topic) => '$userId-$topic';
  static String getGroup(String topic) => 'group-$topic';
  static String defaultChannelKey = 'default';

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
    NotificationTopics.foodToday: _l10n.notificationSystemSettingsFoodTodayDescription,
    NotificationTopics.lowCredit: _l10n.notificationSystemSettingsLowCreditDescription,
    NotificationTopics.nextWeekFoodCheck: _l10n.notificationSystemSettingsNextWeekFoodCheckDescription,
  };

  static List<NotificationChannelGroup> channelGroups = [
    NotificationChannelGroup(channelGroupKey: getGroup(NotificationTopics.foodToday), channelGroupName: _l10n.notificationChannelNameFoodToday),
    NotificationChannelGroup(channelGroupKey: getGroup(NotificationTopics.lowCredit), channelGroupName: _l10n.notificationChannelNameLowCredit),
    NotificationChannelGroup(
      channelGroupKey: getGroup(NotificationTopics.nextWeekFoodCheck),
      channelGroupName: _l10n.notificationChannelNameNextWeekFoodCheck,
    ),
  ];
}

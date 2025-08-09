import 'package:autojidelna/core/notifications/notification_topics.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/core/utils/url.dart';

import 'package:awesome_notifications/awesome_notifications.dart';

class UserChannelService {
  String userIdGen(SafeAccount account) => '${Url.clean(account.url)}-${account.username}';
  String getChannelKey(String userId, String topic) => '$userId-$topic';
  String getGroup(String topic) => 'group-$topic';

  Future<void> createChannelsForUser(SafeAccount account) async {
    String userId = userIdGen(account);
    for (final topic in NotificationTopics.all) {
      final channelKey = getChannelKey(userId, topic);
      final channelGroupKey = getGroup(topic);

      await AwesomeNotifications().setChannel(
        NotificationChannel(
          channelKey: channelKey,
          channelName: account.username,
          channelDescription: NotificationTopics.channelDescriptions[topic],
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
}

import 'package:autojidelna/core/notifications/notification_topics.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NotificationHandler.handleIncomingMessage(message);
}

class NotificationHandler {
  static void handleIncomingMessage(RemoteMessage message) async => _runTopicAction(message.data['type']);

  static void _runTopicAction(String? topic) {
    if (topic == null) return;

    // TODO: replace with actual topic based methods
    final actions = <String, Function>{
      NotificationTopics.foodToday: _placeholderNotification,
      NotificationTopics.lowCredit: _placeholderNotification,
      NotificationTopics.nextWeekFoodCheck: _placeholderNotification,
    };

    actions[topic]?.call(topic);
  }

  static void _placeholderNotification(String topic) async {
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
}

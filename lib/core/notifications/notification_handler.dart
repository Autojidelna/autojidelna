import 'package:autojidelna/core/notifications/notification_topics.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NotificationHandler.handleIncomingMessage(message);
}

class NotificationHandler {
  static void handleIncomingMessage(RemoteMessage message) async {
    Map<String, dynamic> data = message.data;
    final topic = data['type'];

    // Run specific function based on topic
    _runTopicAction(topic);
  }

  static void _runTopicAction(String? topic) {
    if (topic == null) return;

    final actions = <String, Function>{
      NotificationTopics.foodToday: () => throw UnimplementedError('Food Today logic not implemented'),
      NotificationTopics.lowCredit: () => throw UnimplementedError('Low Credit logic not implemented'),
      NotificationTopics.nextWeekFoodCheck: () => throw UnimplementedError('Next Week Food Check logic not implemented'),
    };

    actions[topic]?.call();
  }
}

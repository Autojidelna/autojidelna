import 'package:autojidelna/core/notifications/notification_handler.dart';
import 'package:autojidelna/core/notifications/notification_topics.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/widgets/section_title.dart';
import 'package:flutter/material.dart';

// TODO: fix

class NotificationActionButton extends StatelessWidget {
  const NotificationActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(context.l10n.notifications),
        ListTile(
          title: const Text('Today\'s food notification'),
          // onTap: () => NotificationHandler.handleIncomingMessage(const RemoteMessage(data: {'type': NotificationTopics.foodToday})),
        ),
        ListTile(
          title: const Text('Low credit notification'),
          // onTap: () => NotificationHandler.handleIncomingMessage(const RemoteMessage(data: {'type': NotificationTopics.lowCredit})),
        ),
        ListTile(
          title: const Text('Weekly food check notification'),
          // onTap: () => NotificationHandler.handleIncomingMessage(const RemoteMessage(data: {'type': NotificationTopics.nextWeekFoodCheck})),
        ),
      ],
    );
  }
}

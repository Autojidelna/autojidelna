import 'dart:ui';

import 'package:autojidelna/core/notifications/user_channel_service.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';

import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationTopics {
  static final L10n _l10n = lookupL10n(const Locale('cs'));
  static const String foodToday = 'food_today_1100';
  static const String lowCredit = 'low_credit_1500';
  static const String nextWeekFoodCheck = 'next_week_food_check_1500';

  // If you need to add more in future, just append here
  static const List<String> all = [
    foodToday,
    lowCredit,
    nextWeekFoodCheck,
  ];

  static Map<String, String> channelDescriptions = {
    foodToday: _l10n.notificationFoodTodayDescription,
    lowCredit: _l10n.notificationLowCreditDescription,
    nextWeekFoodCheck: _l10n.notificationNextWeekFoodCheckDescription,
  };

  static List<NotificationChannelGroup> channelGroups = [
    NotificationChannelGroup(channelGroupKey: UserChannelService().getGroup(foodToday), channelGroupName: _l10n.channelNameDish),
    NotificationChannelGroup(channelGroupKey: UserChannelService().getGroup(lowCredit), channelGroupName: _l10n.channelNameLowCredit),
    NotificationChannelGroup(channelGroupKey: UserChannelService().getGroup(nextWeekFoodCheck), channelGroupName: _l10n.channelNameOrdered),
  ];
}

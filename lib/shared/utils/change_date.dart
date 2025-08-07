import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/shared/settings/providers/settings_notifiers.dart';
import 'package:autojidelna/features/canteen/application/canteen.provider.dart';
import 'package:autojidelna/shared/utils/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

changeDate(WidgetRef ref, DateTime newDate) async {
  if (!App.pageController.hasClients && !App.listController.hasClients) return;

  bool animate = true;
  if (ref.read(canteenProvider).selectedDate.difference(newDate).inDays.abs() > 6) animate = false;

  ref.read(canteenProvider).setSelectedDate(newDate);
  final int dayIndex = newDate.toIndex();
  bool listUi = ref.read(listUiProvider);

  if (!animate) {
    // Offset to show the correct date on date picker button
    listUi ? App.listController.sliverController.jumpToIndex(dayIndex, offset: -.1) : App.pageController.jumpToPage(dayIndex);
    return;
  }

  listUi
      ? App.listController.sliverController.animateToIndex(dayIndex, offset: -.1, duration: Durations.medium1, curve: Curves.easeInOut)
      : App.pageController.animateToPage(dayIndex, duration: Durations.medium1, curve: Curves.easeInOut);
}

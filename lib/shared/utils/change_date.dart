import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/shared/settings/providers/settings_notifiers.dart';
import 'package:autojidelna/features/canteen/application/canteen.provider.dart';
import 'package:autojidelna/shared/utils/datetime_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Prevent Friday <-> Monday loop jumping
final _pageChangeLockProvider = StateProvider<bool>((ref) => false);

changeDate(DateTime newDate) async {
  if (!App.pageController.hasClients && !App.listController.hasClients) return;
  final container = App.globalContainer;

  // If we're in the middle of a programmatic change, ignore further callbacks.
  if (container.read(_pageChangeLockProvider)) return;

  final canteen = container.read(canteenProvider);
  final prevDate = canteen.selectedDate;

  if (container.read(skipWeekendsProvider)) newDate = _jumpToWeekDay(prevDate, newDate);
  final bool animate = prevDate.difference(newDate).inDays.abs() <= 7;
  canteen.setSelectedDate(newDate);

  final int dayIndex = newDate.toIndex();
  final bool listUi = container.read(listUiProvider);

  container.read(_pageChangeLockProvider.notifier).state = true;

  if (!animate) {
    listUi ? App.listController.sliverController.jumpToIndex(dayIndex, offset: -.1) : App.pageController.jumpToPage(dayIndex);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      container.read(_pageChangeLockProvider.notifier).state = false;
    });
    return;
  }

  listUi
      ? await App.listController.sliverController.animateToIndex(dayIndex, offset: -.1, duration: Durations.medium1, curve: Curves.easeInOut)
      : await App.pageController.animateToPage(dayIndex, duration: Durations.medium1, curve: Curves.easeInOut);

  container.read(_pageChangeLockProvider.notifier).state = false;
}

DateTime _jumpToWeekDay(DateTime prevDate, DateTime newDate) {
  // Compute direction from raw movement:
  // +1 = forward (later), -1 = backward (earlier), 0 = no movement
  final int direction = newDate.isAfter(prevDate)
      ? 1
      : newDate.isBefore(prevDate)
          ? -1
          : 0;

  DateTime adjustedDate = newDate.normalize;

  while (adjustedDate.isWeekend) {
    adjustedDate = adjustedDate.add(Duration(days: direction));
  }
  return adjustedDate;
}

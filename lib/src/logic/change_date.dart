import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/shared/settings/providers/settings_notifiers.dart';
import 'package:autojidelna/src/_global/providers/canteen.provider.dart';
import 'package:autojidelna/src/logic/datetime_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

changeDate(BuildContext context, DateTime newDate, {bool animate = true}) async {
  if (!App.pageController.hasClients && !App.listController.hasClients) return;

  ProviderContainer container = ProviderScope.containerOf(context);

  container.read(canteenProvider).setSelectedDate(newDate);
  final int dayIndex = convertDateTimeToIndex(newDate);
  bool listUi = container.read(listUiProvider);

  if (!animate) {
    listUi ? App.listController.sliverController.jumpToIndex(dayIndex) : App.pageController.jumpToPage(dayIndex);
    return;
  }

  listUi
      ? App.listController.sliverController.animateToIndex(dayIndex, duration: Durations.medium1, curve: Curves.easeInOut)
      : App.pageController.animateToPage(dayIndex, duration: Durations.medium1, curve: Curves.easeInOut);
}

import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/shared/settings/providers/settings_notifiers.dart';
import 'package:autojidelna/shared/utils/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/selected_date.g.dart';

@Riverpod(keepAlive: true)
class SelectedDate extends _$SelectedDate {
  @override
  DateTime build() {
    return DateTime.now().normalize;
  }

  bool _lock = false;

  @override
  set state(DateTime newState) => super.state = newState.normalize;
  DateTime update(DateTime Function(DateTime state) cb) => state = cb(state);
  void setDayIndex(int dayIndex) => state = dayIndex.toDateTime();

  /// Changes current date to the new date, uses the [App.pageController] and [App.listController] to jump/animate to the desired date
  /// ARGS:
  /// - [newDate] - New date
  /// - [userInteracted] - Used to decide if the date was changed by the user directly (through page scroll/ page swipe in pageview)
  ///   or through a medium (like a button), if this is false, jumping using [App.pageController] and [App.listController] is always used
  void changeDate(DateTime newDate, [bool userInteracted = true]) async {
    // If we're in the middle of a programmatic change, ignore further callbacks.
    if (_lock) return;
    if (!App.pageController.hasClients && !App.listController.hasClients) return;

    newDate = newDate.normalize;

    if (newDate.isWeekend && ref.read(skipWeekendsProvider)) newDate = _jumpToWeekDay(newDate);

    int dayDifference = state.difference(newDate).inDays.abs();
    state = newDate;
    if (dayDifference < 2 && userInteracted) return;

    final bool listUi = ref.read(listUiProvider);
    final int dayIndex = state.toIndex();

    _lock = true;

    if (dayDifference > 7) {
      listUi ? App.listController.sliverController.jumpToIndex(dayIndex, offset: -.1) : App.pageController.jumpToPage(dayIndex);
    } else {
      listUi
          ? await App.listController.sliverController.animateToIndex(dayIndex, offset: -.1, duration: Durations.medium1, curve: Curves.easeInOut)
          : await App.pageController.animateToPage(dayIndex, duration: Durations.medium1, curve: Curves.easeInOut);
    }
    _lock = false;
  }

  DateTime _jumpToWeekDay(DateTime newDate) {
    // Compute direction from raw movement:
    // +1 = forward (later), -1 = backward (earlier), 0 = no movement
    final int direction = newDate.isAfter(state)
        ? 1
        : newDate.isBefore(state)
        ? -1
        : 0;

    DateTime adjustedDate = newDate.normalize;

    while (adjustedDate.isWeekend) {
      adjustedDate = adjustedDate.add(Duration(days: direction));
    }
    return adjustedDate.toLocal().normalize;
  }
}

import 'package:autojidelna/shared/utils/datetime_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _SelectedDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => DateTime.now().normalize;

  @override
  set state(DateTime newState) => super.state = newState.normalize;
  DateTime update(DateTime Function(DateTime state) cb) => state = cb(state);
  void setDayIndex(int dayIndex) => state = dayIndex.toDateTime();
}

final selectedDateProvider = NotifierProvider<_SelectedDateNotifier, DateTime>(_SelectedDateNotifier.new);

import 'package:autojidelna/shared/config/dates.dart';

extension Utils on DateTime {
  bool get isWeekend => weekday > 5;
  DateTime get normalize => DateTime(year, month, day);

  /// Converts [DateTime] to [int] based on the difference from [Dates.minimalDate]
  int toIndex() => Dates.minimalDate.difference(this).inDays.abs();
}

extension DateTimeUtils on int {
  /// Converts [int] to [DateTime] based on the difference from [Dates.minimalDate]
  DateTime toDateTime() {
    DateTime newDate = Dates.minimalDate.add(Duration(days: this));
    while (newDate.hour != 0 && newDate.hour > 12) {
      newDate = newDate.add(const Duration(hours: 1));
    }
    while (newDate.hour != 0 && newDate.hour < 12) {
      newDate = newDate.subtract(const Duration(hours: 1));
    }
    return newDate.normalize;
  }
}

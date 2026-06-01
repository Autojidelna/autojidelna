import 'dart:async';

import 'package:autojidelna/features/canteen/application/providers.dart';
import 'package:autojidelna/features/canteen/application/selected_date.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/utils/string_extension.dart';
import 'package:autojidelna/shared/settings/providers/settings_notifiers.dart';
import 'package:autojidelna/shared/config/dates.dart';
import 'package:autojidelna/shared/utils/change_date.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:autojidelna/shared/widgets/configured_dialog.dart';
import 'package:autojidelna/features/canteen/application/helpers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:icanteenlib/canteenlib.dart';
import 'package:table_calendar/table_calendar.dart';

void showCustomDatePicker(BuildContext context) => configuredDialog(context, builder: (_) => const _CustomDatePicker());

class _CustomDatePicker extends ConsumerStatefulWidget {
  const _CustomDatePicker();

  @override
  ConsumerState<_CustomDatePicker> createState() => __CustomDatePickerState();
}

class __CustomDatePickerState extends ConsumerState<_CustomDatePicker> {
  late String locale;

  late bool bigMarkersEnabled;
  late DateTime selectedDate;

  late ColorScheme colorScheme;
  late final TextStyle defaultTextStyle;
  late final BoxDecoration defaultDecoration;

  late DateTime appFocusedDate;
  late DateTime userFocusedDate;
  late int visibleMonth;

  List<DateTime> orderedFoodDays = [];
  List<DateTime> availableFoodDays = [];

  List<dynamic> eventLoader(DateTime day) {
    Jidelnicek? menu = ref.read(denniNabidkaProvider(day)).unwrapPrevious().value;

    if (menu == null) return [];
    if (!bigMarkersEnabled) return menu.nabidka;

    /// This for loop is used for [defaultBuilder]
    for (Jidlo dish in menu.nabidka) {
      if (orderedFoodDays.contains(day) || availableFoodDays.contains(day)) break;
      if (getPrimaryState(dish.stav)) {
        orderedFoodDays.add(day);
        break;
      }
      if (isButtonEnabled(dish.stav)) {
        availableFoodDays.add(day);
        break;
      }
    }

    return [];
  }

  void onPageChanged(DateTime focusedDay) {
    setState(() {
      visibleMonth = focusedDay.month;
      appFocusedDate = focusedDay;
    });
  }

  void onConfirm(WidgetRef ref) {
    Navigator.of(context).pop();
    unawaited(changeDate(ref, userFocusedDate));
  }

  void onDaySelected(WidgetRef ref, DateTime selectedDay, DateTime focusedDay) {
    if (isSameDay(selectedDay, userFocusedDate)) {
      onConfirm(ref);
      return;
    }
    setState(() {
      userFocusedDate = selectedDay;
    });
  }

  @override
  void initState() {
    super.initState();
    bigMarkersEnabled = ref.read(bigCalendarMarkersProvider);
    selectedDate = ref.read(selectedDateProvider);

    defaultDecoration = const BoxDecoration(shape: BoxShape.circle);

    appFocusedDate = selectedDate;
    userFocusedDate = selectedDate;
    visibleMonth = selectedDate.month;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    locale = Localizations.localeOf(context).toLanguageTag();
    colorScheme = Theme.of(context).colorScheme;
    defaultTextStyle = Theme.of(context).textTheme.titleMedium!;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            locale: locale,
            sixWeekMonthsEnforced: true,
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              leftChevronVisible: visibleMonth != Dates.minimalDate.month,
              rightChevronVisible: visibleMonth != Dates.maximalDate.month,
              titleTextStyle: Theme.of(context).textTheme.headlineSmall!,
              decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest.withAlpha(16)),
            ),
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              markersMaxCount: 3,
              markerSizeScale: 0.3,
              markerDecoration: defaultDecoration.copyWith(color: colorScheme.secondary),
              todayTextStyle: defaultTextStyle.copyWith(color: colorScheme.primary),
              todayDecoration: defaultDecoration.copyWith(border: Border.all(color: colorScheme.primary)),
              selectedTextStyle: defaultTextStyle.copyWith(color: colorScheme.onInverseSurface),
              selectedDecoration: defaultDecoration.copyWith(color: colorScheme.primary),
              defaultTextStyle: defaultTextStyle,
              defaultDecoration: defaultDecoration,
            ),
            rowHeight: 45,
            daysOfWeekHeight: 25,
            focusedDay: appFocusedDate,
            currentDay: DateTime.now(),
            firstDay: Dates.minimalDate,
            lastDay: Dates.maximalDate,
            selectedDayPredicate: (day) => isSameDay(userFocusedDate, day),
            onDaySelected: (a, b) => onDaySelected(ref, a, b),
            onPageChanged: onPageChanged,
            eventLoader: eventLoader,
            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, day) => _headerTitle(locale, day, context),
              singleMarkerBuilder: !bigMarkersEnabled ? (context, _, dish) => _markerTemplate(context, dish as Jidlo) : null,
              selectedBuilder: (context, day, _) => _cellTemplate(context, userFocusedDate, state: CellState.selected),
              todayBuilder: (context, day, _) => _cellTemplate(context, day, state: CellState.today),
              defaultBuilder: (context, day, _) {
                if (!bigMarkersEnabled) return null;
                if (orderedFoodDays.contains(day)) return _cellTemplate(context, day, state: CellState.ordered);
                if (availableFoodDays.contains(day)) return _cellTemplate(context, day, state: CellState.available);
                return null;
              },
            ),
          ),
          const CustomDivider(height: 0, isTransparent: false),
          _actionButtons(context, () => onConfirm(ref)),
        ],
      ),
    );
  }
}

Center _headerTitle(String locale, DateTime day, BuildContext context) {
  return Center(child: Text(DateFormat(DateFormat.YEAR_MONTH, locale).format(day).capitalize(), style: Theme.of(context).textTheme.headlineSmall!));
}

Center _cellTemplate(BuildContext context, DateTime date, {CellState? state}) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;
  final TextStyle textStyle = Theme.of(context).textTheme.titleMedium!;
  double size = 40;
  Color color = Colors.transparent;
  Color textColor = colorScheme.onInverseSurface;
  Border? border;

  switch (state) {
    case CellState.today:
      textColor = colorScheme.onSurface;
      border = Border.all(color: colorScheme.onSurface, width: 2);
      break;
    case CellState.selected:
      color = colorScheme.onSurface;
      break;
    case CellState.ordered:
      size = 35;
      color = colorScheme.primary;
      break;
    case CellState.available:
      size = 35;
      color = colorScheme.secondary;
      break;
    default:
  }

  return Center(
    child: Container(
      height: size,
      width: size,
      decoration: BoxDecoration(color: color, border: border, shape: BoxShape.circle),
      child: Center(
        child: Text(
          date.day.toString(),
          textAlign: TextAlign.center,
          style: textStyle.copyWith(color: textColor),
        ),
      ),
    ),
  );
}

Widget? _markerTemplate(BuildContext context, Jidlo dish) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;
  double size = 10;
  final bool ordered = getPrimaryState(dish.stav);

  if (!isButtonEnabled(dish.stav) && !ordered) return const SizedBox();

  Color color = ordered ? colorScheme.primary : colorScheme.secondary;

  return Container(
    height: size,
    width: size,
    margin: const EdgeInsets.symmetric(horizontal: 1),
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

Row _actionButtons(BuildContext context, void Function() onConfirm) {
  final L10n l10n = context.l10n;

  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.cancel)),
      TextButton(onPressed: onConfirm, child: Text(l10n.ok)),
      const SizedBox(width: 10),
    ],
  );
}

/// Used by custom date picker to decide how to render a cell
enum CellState { today, selected, ordered, available }

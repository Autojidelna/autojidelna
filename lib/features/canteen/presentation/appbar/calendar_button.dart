import 'package:autojidelna/shared/settings/providers/settings_notifiers.dart';
import 'package:autojidelna/shared/utils/get_correct_date_string.dart';
import 'package:autojidelna/features/canteen/application/selected_date.dart';
import 'package:autojidelna/features/canteen/presentation/appbar/custom_date_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37.5,
      child: MaterialButton(
        textColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Theme.of(context).colorScheme.onSurfaceVariant, width: 1.75),
        ),
        onPressed: () => showCustomDatePicker(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_month_outlined),
            const SizedBox(width: 8),
            Consumer(
              builder: (context, ref, _) {
                final DateTime selectedDate = ref.watch(selectedDateProvider);
                String day = DateFormat(DateFormat.ABBR_WEEKDAY, Localizations.localeOf(context).toLanguageTag()).format(selectedDate);
                String date = getCorrectDateString(ref.watch(dateFormatOptionProvider), date: selectedDate);
                return Text('$day - $date');
              },
            ),
          ],
        ),
      ),
    );
  }
}

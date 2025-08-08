import 'package:autojidelna/shared/utils/change_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JumpToTodayButton extends ConsumerWidget {
  const JumpToTodayButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 35,
      height: 35,
      child: MaterialButton(
        textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Theme.of(context).colorScheme.onSurfaceVariant, width: 1.75),
        ),
        onPressed: () => changeDate(DateTime.now()),
        child: Text(DateTime.now().day.toString()),
      ),
    );
  }
}

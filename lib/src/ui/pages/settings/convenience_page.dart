import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/src/_global/riverpod/settings/settings.riverpod.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/src/ui/widgets/scroll_view_column.dart';
import 'package:autojidelna/src/ui/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ConveniencePage extends ConsumerWidget {
  const ConveniencePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n lang = context.l10n;

    final skipWeekends = ref.watch(skipWeekendsNotifierProvider);
    final skipWeekendsNotifier = ref.read(skipWeekendsNotifierProvider.notifier);
    final bigCalendarMarkers = ref.watch(bigCalendarMarkersNotifierProvider);
    final bigCalendarMarkersNotifier = ref.read(bigCalendarMarkersNotifierProvider.notifier);
    final listUi = ref.watch(listUiNotifierProvider);
    final listUiNotifier = ref.read(listUiNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(lang.convenience)),
      body: ScrollViewColumn(
        children: [
          SectionTitle(lang.convenience),
          // TODO: skip weekends
          SwitchListTile(
            title: Text(lang.skipWeekends),
            value: skipWeekends,
            onChanged: skipWeekendsNotifier.update,
          ),
          SwitchListTile(
            title: Text(lang.calendarBigMarkers),
            value: bigCalendarMarkers,
            onChanged: bigCalendarMarkersNotifier.update,
          ),
          SectionTitle(lang.experimental),
          SwitchListTile(
            title: Text(lang.listUi),
            subtitle: Text(lang.listUiSubtitle),
            value: listUi,
            onChanged: listUiNotifier.update,
          ),
        ],
      ),
    );
  }
}

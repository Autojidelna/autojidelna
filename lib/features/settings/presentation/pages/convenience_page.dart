import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/shared/settings/providers/settings_notifiers.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/widgets/scroll_view_column.dart';
import 'package:autojidelna/shared/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ConveniencePage extends ConsumerWidget {
  const ConveniencePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.convenience)),
      body: ScrollViewColumn(
        children: [
          SectionTitle(l10n.convenience),
          SwitchListTile(
            title: Text(l10n.skipWeekends),
            value: ref.watch(skipWeekendsProvider),
            onChanged: ref.read(skipWeekendsProvider.notifier).update,
          ),
          SwitchListTile(
            title: Text(l10n.calendarBigMarkers),
            value: ref.watch(bigCalendarMarkersProvider),
            onChanged: ref.read(bigCalendarMarkersProvider.notifier).update,
          ),
          SectionTitle(l10n.experimental),
          SwitchListTile(
            title: Text(l10n.listUi),
            subtitle: Text(l10n.listUiSubtitle),
            value: ref.watch(listUiProvider),
            onChanged: ref.read(listUiProvider.notifier).update,
          ),
        ],
      ),
    );
  }
}

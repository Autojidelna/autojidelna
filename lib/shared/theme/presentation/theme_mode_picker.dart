import 'package:autojidelna/shared/theme/application/theme_notifier.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeModePicker extends ConsumerWidget {
  const ThemeModePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .9,
      child: SegmentedButton<ThemeMode>(
        showSelectedIcon: false,
        selected: {ref.watch(themeProvider.select((data) => data.themeMode))},
        onSelectionChanged: (Set<ThemeMode> selected) => ref.read(themeProvider.notifier).setThemeMode(selected.first),
        segments: [
          ButtonSegment<ThemeMode>(value: ThemeMode.system, label: Text(l10n.themeModeSystem)),
          ButtonSegment<ThemeMode>(value: ThemeMode.light, label: Text(l10n.themeModeLight)),
          ButtonSegment<ThemeMode>(value: ThemeMode.dark, label: Text(l10n.themeModeDark)),
        ],
      ),
    );
  }
}

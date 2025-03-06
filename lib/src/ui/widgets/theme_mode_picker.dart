import 'package:autojidelna/src/_global/riverpod/theme/theme.riverpod.dart';
import 'package:autojidelna/src/lang/l10n_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeModePicker extends ConsumerWidget {
  const ThemeModePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = context.l10n;
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .9,
      child: SegmentedButton<ThemeMode>(
        showSelectedIcon: false,
        selected: {ref.watch(themeNotifierProvider).themeMode},
        onSelectionChanged: (Set<ThemeMode> selected) => ref.read(themeNotifierProvider.notifier).setThemeMode(selected.first),
        segments: [
          ButtonSegment<ThemeMode>(value: ThemeMode.system, label: Text(lang.themeModeSystem)),
          ButtonSegment<ThemeMode>(value: ThemeMode.light, label: Text(lang.themeModeLight)),
          ButtonSegment<ThemeMode>(value: ThemeMode.dark, label: Text(lang.themeModeDark)),
        ],
      ),
    );
  }
}

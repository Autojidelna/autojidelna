import 'package:autojidelna/src/_global/riverpod/theme/theme.riverpod.dart';
import 'package:autojidelna/src/lang/l10n_context_extension.dart';
import 'package:autojidelna/src/types/freezed/theme_state/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AmoledModeSwitch extends ConsumerWidget {
  const AmoledModeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Texts lang = context.l10n;

    final ThemeNotifier themeNotifier = ref.read(themeNotifierProvider.notifier);
    final ThemeState themeProvider = ref.watch(themeNotifierProvider);

    final bool isBright = ref.watch(isBrightProvider(MediaQuery.platformBrightnessOf(context)));

    return SwitchListTile(
      title: Text(lang.amoledMode),
      subtitle: Text(lang.amoledModeSubtitle),
      value: themeProvider.amoledMode,
      onChanged: isBright ? null : themeNotifier.setAmoledMode,
    );
  }
}

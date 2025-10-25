import 'package:autojidelna/shared/theme/application/theme_notifier.dart';
import 'package:autojidelna/shared/theme/domain/theme_state.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AmoledModeSwitch extends ConsumerWidget {
  const AmoledModeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n l10n = context.l10n;

    final ThemeNotifier themeNotifier = ref.read(themeProvider.notifier);
    final ThemeState themeProv = ref.watch(themeProvider);

    final bool isBright = ref.watch(isBrightProvider(MediaQuery.platformBrightnessOf(context)));

    return SwitchListTile(
      title: Text(l10n.amoledMode),
      subtitle: Text(l10n.amoledModeSubtitle),
      value: themeProv.amoledMode,
      onChanged: isBright ? null : themeNotifier.setAmoledMode,
    );
  }
}

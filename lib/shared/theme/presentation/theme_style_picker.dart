import 'package:autojidelna/shared/theme/app_themes.dart';
import 'package:autojidelna/shared/theme/domain/color_style.dart';
import 'package:autojidelna/shared/theme/domain/theme_state.dart';
import 'package:autojidelna/shared/theme/application/theme_notifier.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeStylePicker extends ConsumerWidget {
  const ThemeStylePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeNotifier notifier = ref.read(themeProvider.notifier);
    final ThemeState provider = ref.watch(themeProvider);

    return SizedBox(
      height: 225,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: ThemeStyle.values.length,
        itemBuilder: (context, index) {
          ThemeStyle themeStyle = ThemeStyle.values[index];
          final bool isBright = ref.watch(isBrightProvider(MediaQuery.platformBrightnessOf(context)));

          ThemeData theme = AppThemes.theme(
            isBright ? notifier.colorSchemeLight(themeStyle) : notifier.colorSchemeDark(themeStyle),
            amoledMode: provider.amoledMode,
          );

          BorderRadius radius = BorderRadius.circular(16);

          ButtonStyle style = OutlinedButton.styleFrom(
            backgroundColor: theme.scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(borderRadius: radius),
            fixedSize: const Size.fromWidth(125),
            padding: EdgeInsets.all(0),
            side: BorderSide(
              width: 3,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: ThemeStyle.values[index] == provider.themeStyle ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
            ),
          );

          return Theme(
            data: theme,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: OutlinedButton(
                style: style,
                onPressed: () => notifier.setThemeStyle(ThemeStyle.values[index]),
                child: ClipRRect(
                  borderRadius: radius,
                  child: Column(
                    children: [
                      SizedBox(height: 35, child: AppBar(automaticallyImplyLeading: false)),
                      const CustomDivider(height: 6),
                      foodTileColorSchemePreview(theme, theme.colorScheme.primary),
                      foodTileColorSchemePreview(theme, theme.colorScheme.secondary),
                      const Expanded(child: SizedBox()),
                      fakeNavigationBar(theme),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox fakeNavigationBar(ThemeData theme) {
    final Icon icon = Icon(Icons.circle, size: 4, color: theme.colorScheme.onPrimary);
    return SizedBox(
      height: 35,
      child: NavigationBar(
        onDestinationSelected: null,
        destinations: [
          const SizedBox(),
          Container(
            height: 10,
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: theme.navigationBarTheme.indicatorColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: icon,
          ),
          ...List.generate(
            4,
            (int i) => SizedBox(child: i == 2 ? Padding(padding: const EdgeInsets.only(bottom: 4), child: icon) : const SizedBox()),
          ),
        ],
      ),
    );
  }

  Widget foodTileColorSchemePreview(ThemeData theme, Color buttonColor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: (theme.cardTheme.shape as RoundedRectangleBorder).copyWith(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          const CustomDivider(isTransparent: false),
          Container(
            height: 15,
            width: 100,
            margin: const EdgeInsets.fromLTRB(8, 20, 8, 8),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(12.5),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/theme/presentation/amoled_mode_switch.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:autojidelna/features/settings/presentation/date_format_picker.dart';
import 'package:autojidelna/shared/widgets/scroll_view_column.dart';
import 'package:autojidelna/shared/widgets/section_title.dart';
import 'package:autojidelna/shared/theme/presentation/theme_mode_picker.dart';
import 'package:autojidelna/shared/theme/presentation/theme_style_picker.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appearance)),
      body: ScrollViewColumn(
        children: [
          SectionTitle(l10n.theme),
          const CustomDivider(height: 24),
          const ThemeModePicker(),
          const CustomDivider(height: 38),
          const ThemeStylePicker(),
          const CustomDivider(height: 30),
          const AmoledModeSwitch(),
          SectionTitle(l10n.display),
          const DateFormatPickerListTile(),
        ],
      ),
    );
  }
}

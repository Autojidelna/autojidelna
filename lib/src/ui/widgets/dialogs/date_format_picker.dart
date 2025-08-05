import 'package:autojidelna/shared/settings/providers/settings_notifiers.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/src/logic/get_correct_date_string.dart';
import 'package:autojidelna/src/types/theme.dart';
import 'package:autojidelna/src/ui/theme/app_themes.dart';
import 'package:autojidelna/src/ui/widgets/dialogs/configured_alert_dialog.dart';
import 'package:autojidelna/src/ui/widgets/dialogs/configured_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateFormatPickerListTile extends ConsumerWidget {
  const DateFormatPickerListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(context.l10n.dateFormat),
      subtitle: Text(getCorrectDateString(ref.watch(dateFormatOptionProvider), inSettings: true)),
      onTap: () => configuredDialog(context, builder: (context) => const DateFormatPicker()),
    );
  }
}

class DateFormatPicker extends ConsumerWidget {
  const DateFormatPicker({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n lang = context.l10n;
    final notifier = ref.read(dateFormatOptionProvider.notifier);
    final provider = ref.watch(dateFormatOptionProvider);

    return ConfiguredAlertDialog(
      title: lang.dateFormat,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: DateFormatOptions.values
              .map(
                (format) => ListTile(
                  minVerticalPadding: 0,
                  visualDensity: const VisualDensity(vertical: -4),
                  title: Text(getCorrectDateString(format, inSettings: true)),
                  titleTextStyle: AppThemes.textTheme.bodyMedium,
                  trailing: provider == format ? const Icon(Icons.check) : null,
                  onTap: () {
                    notifier.update(format);
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

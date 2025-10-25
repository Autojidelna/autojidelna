import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/types/stav_jidla.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/shared/widgets/configured_alert_dialog.dart';
import 'package:autojidelna/shared/widgets/configured_dialog.dart';
import 'package:autojidelna/features/canteen/application/get_obed_text.dart';
import 'package:autojidelna/features/canteen/application/ordering.dart';

import 'package:icanteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/adapters.dart';

void burzaAlertDialog(BuildContext context, Jidlo updatedDish, StavJidla stav) {
  if (stav != StavJidla.objednanoPouzeNaBurzu || Hive.box(Boxes.appState).get(HiveKeys.appState.hideBurzaAlertDialog, defaultValue: false)) {
    pressed(context, updatedDish, stav);
    return;
  }

  final L10n l10n = context.l10n;
  ValueNotifier<bool> checkbox = ValueNotifier<bool>(false);

  return configuredDialog(
    context,
    builder: (context) => Consumer(
      builder: (context, ref, child) {
        return ConfiguredAlertDialog(
          title: getObedText(context, updatedDish, stav),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(l10n.burzaAlertDialogContent),
              ),
              const SizedBox(height: 2),
              ValueListenableBuilder(
                valueListenable: checkbox,
                builder: (_, value, ___) => CheckboxListTile(
                  value: value,
                  onChanged: (data) async {
                    checkbox.value = data!; // Checkbox isn't tristate so it's save
                    Hive.box(Boxes.appState).put(HiveKeys.appState.hideBurzaAlertDialog, data);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(l10n.dontShowAgain, style: Theme.of(context).listTileTheme.subtitleTextStyle),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.secondary,
                visualDensity: const VisualDensity(vertical: -4),
                padding: const EdgeInsets.only(right: 16),
              ),
              onPressed: () {
                pressed(context, updatedDish, stav);
                Navigator.pop(context);
              },
              child: Text(getObedText(context, updatedDish, stav)),
            ),
            const SizedBox(width: 8),
          ],
        );
      },
    ),
  );
}

import 'package:autojidelna/features/canteen/application/providers.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:autojidelna/shared/snackbars/show_internet_connection_snack_bar.dart';

import 'package:icanteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<void> pressed(BuildContext context, WidgetRef ref, Jidlo dish) async {
  final Canteen canteen = ref.read(currentCanteen)!;
  final L10n l10n = context.l10n;
  final DateTime date = dish.datum;

  final notifier = ref.read(disableInteractions.notifier);
  if (notifier.state) return;
  notifier.state = true;

  if (!await InternetConnectionChecker.instance.hasConnection) {
    final bool value = await showInternetConnectionSnackBar();
    if (value && context.mounted) {
      notifier.state = false;
      await pressed(context, ref, dish);
    }
    return;
  }
  try {
    switch (dish.stav) {
      case StavJidla.objednano:
      case StavJidla.neobjednano:
      case StavJidla.dostupneNaBurze:
      case StavJidla.objednanoPouzeNaBurzu:
      case StavJidla.vlozenoNaBurze:
        try {
          ref.read(denniNabidkaProvider(dish.datum).notifier).provedObjednavku(jidlo: dish);
        } catch (e) {
          showErrorSnackBar(SnackBarOrderingErrors.dishOrdering(l10n));
        }
        break;
      case StavJidla.objednanoVyprsenaPlatnost:
        showErrorSnackBar(SnackBarOrderingErrors.dishCancellationExpired(l10n));
        break;

      case StavJidla.nedostupne:
        if (date.isBefore(DateTime.now())) {
          showErrorSnackBar(SnackBarOrderingErrors.dishCannotBeOrdered(l10n));
          break;
        }
        final stavUctu = canteen.stavUctu;
        final cena = dish.cena;
        if (stavUctu == null || cena == null) {
          showErrorSnackBar(SnackBarOrderingErrors.dishCannotBeOrdered(l10n));
          break;
        }
        if (stavUctu.kredit < dish.cena!) {
          showErrorSnackBar(SnackBarOrderingErrors.insufficientCredit(l10n));
          break;
        }
        showErrorSnackBar(SnackBarOrderingErrors.dishCannotBeOrdered(l10n));
        break;
      case StavJidla.verejne:
        break;
    }
    await ref.read(userProvider).updateUserData();
  } finally {
    notifier.state = false;
  }
}

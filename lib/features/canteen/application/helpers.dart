import 'package:autojidelna/features/canteen/application/providers.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:autojidelna/shared/snackbars/show_internet_connection_snack_bar.dart';
import 'package:autojidelna/shared/utils/datetime_utils.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icanteenlib/canteenlib.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

extension StavJidlaExtension on StavJidla {
  /// Decides, if these states should be treated differently
  bool getPrimaryState() {
    switch (this) {
      case StavJidla.objednano:
      case StavJidla.objednanoPouzeNaBurzu:
      case StavJidla.objednanoVyprsenaPlatnost:
        return true;
      default:
        return false;
    }
  }

  /// Decides, if a button should be enabled, if it has something to do with a food with [StavJidla]
  bool isButtonEnabled() {
    switch (this) {
      case StavJidla.objednano:
      case StavJidla.objednanoPouzeNaBurzu:
      case StavJidla.vlozenoNaBurze:
      case StavJidla.dostupneNaBurze:
      case StavJidla.neobjednano:
        return true;
      default:
        return false;
    }
  }
}

extension JidloExtension on Jidlo {
  String getObedText(BuildContext context) {
    ProviderContainer ref = ProviderScope.containerOf(context);
    final l10n = context.l10n;
    DateTime date = datum;
    switch (stav) {
      case StavJidla.objednano:
        return l10n.cancel;
      case StavJidla.neobjednano:
        return l10n.objednat;
      case StavJidla.objednanoVyprsenaPlatnost:
        return l10n.nelzeZrusit;
      case StavJidla.objednanoPouzeNaBurzu:
        return l10n.vlozitNaBurzu;
      case StavJidla.dostupneNaBurze:
        return l10n.objednatZBurzy;
      case StavJidla.vlozenoNaBurze:
        return l10n.odebratZBurzy;
      case StavJidla.nedostupne:
        final Canteen? canteen = ref.read(currentCanteen);
        final double? kredit = canteen?.stavUctu?.kredit;
        final double? cena = this.cena;
        if (kredit != null && cena != null && kredit < cena && !date.normalize.isBefore(DateTime.now().normalize)) {
          return l10n.errorsInsufficientCredit;
        } else {
          return l10n.nelzeObjednat;
        }
      case StavJidla.verejne:
        return '';
    }
  }

  Future<void> order(BuildContext context) async {
    ProviderContainer ref = ProviderScope.containerOf(context);
    final Canteen canteen = ref.read(currentCanteen)!;
    final L10n l10n = context.l10n;
    final DateTime date = datum;

    final notifier = ref.read(disableInteractions.notifier);
    if (ref.read(disableInteractions)) return;
    notifier.state = true;

    if (!await InternetConnectionChecker.instance.hasConnection) {
      final bool value = await showInternetConnectionSnackBar();
      if (value && context.mounted) {
        notifier.state = false;
        await order(context);
      }
      return;
    }
    try {
      switch (stav) {
        case StavJidla.objednano:
        case StavJidla.neobjednano:
        case StavJidla.dostupneNaBurze:
        case StavJidla.objednanoPouzeNaBurzu:
        case StavJidla.vlozenoNaBurze:
          try {
            ref.read(denniNabidkaProvider(datum).notifier).provedObjednavku(jidlo: this);
          } catch (e) {
            showErrorSnackBar(SnackBarOrderingErrors.dishOrdering(l10n));
          }
          break;
        case StavJidla.objednanoVyprsenaPlatnost:
          showInfoSnackBar(SnackBarOrderingErrors.dishCancellationExpired(l10n));
          break;

        case StavJidla.nedostupne:
          if (date.isBefore(DateTime.now())) {
            showInfoSnackBar(SnackBarOrderingErrors.dishCannotBeOrdered(l10n));
            break;
          }
          final StavUctu? stavUctu = canteen.stavUctu;
          final double? cena = this.cena;
          if (stavUctu == null || cena == null) {
            showErrorSnackBar(SnackBarOrderingErrors.dishCannotBeOrdered(l10n));
            break;
          }
          if (stavUctu.kredit < cena) {
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
}

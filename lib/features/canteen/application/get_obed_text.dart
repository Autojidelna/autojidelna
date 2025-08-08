import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/types/stav_jidla.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/features/canteen/application/canteen.provider.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';

import 'package:canteenlib/canteenlib.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String getObedText(BuildContext context, Jidlo dish, StavJidla stavJidla) {
  final ProviderContainer container = ProviderScope.containerOf(context);
  final l10n = context.l10n;
  DateTime date = dish.den;
  Jidelnicek menu = container.read(canteenProvider).getCachedMenu(date)!;
  switch (stavJidla) {
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
      try {
        bool jeVeDneDostupnyObed = false;
        int prvniIndex = -1;

        for (int i = 0; i < menu.jidla.length; i++) {
          if (menu.jidla[i].lzeObjednat ||
              menu.jidla[i].objednano ||
              container.read(canteenProvider).dishOnMarketplace(menu.jidla[i]) ||
              menu.jidla[i].burzaUrl != null) {
            jeVeDneDostupnyObed = true;
            break;
          } else {
            prvniIndex = i;
          }
        }
        if (!jeVeDneDostupnyObed && prvniIndex == menu.jidla.indexOf(dish)) cannotBeOrderedFix(context, date);
      } catch (e) {
        // TODO: move to analytics service
        // if (analyticsEnabledGlobally && analytics != null) unawaited(FirebaseCrashlytics.instance.recordError(e, StackTrace.current));

        //hope it's not important
      }
      Uzivatel uzivatel = container.read(userProvider).user!.data;
      if (uzivatel.kredit < dish.cena! && !date.isBefore(DateTime.now())) {
        return l10n.errorsInsufficientCredit;
      } else {
        return l10n.nelzeObjednat;
      }
  }
}

void cannotBeOrderedFix(BuildContext context, DateTime date) async {
  FirebaseAnalytics.instance.logEvent(name: 'cannotBeOrderedFix');
  final ProviderContainer container = ProviderScope.containerOf(context);
  final l10n = context.l10n;
  await Future.delayed(const Duration(milliseconds: 200));
  try {
    if (!date.isBefore(DateTime.now())) {
      final CanteenProvider prov = container.read(canteenProvider);
      Jidelnicek jidelnicekCheck = prov.getCachedMenu(date)!;

      for (int i = 0; i < jidelnicekCheck.jidla.length; i++) {
        if (prov.getCachedMenu(date)!.jidla[i].lzeObjednat != jidelnicekCheck.jidla[i].lzeObjednat) {
          prov.setMenu(jidelnicekCheck);
          return;
        }
      }
    }
  } catch (e) {
    showErrorSnackBar(SnackBarAuthErrors.connectionFailed(l10n));
  }
}

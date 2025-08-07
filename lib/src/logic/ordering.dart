import 'dart:async';

import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/core/analytics/statistic_type.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/src/_global/providers/account.provider.dart';
import 'package:autojidelna/src/_global/providers/canteen.provider.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/src/logic/show_snack_bar.dart';
import 'package:autojidelna/core/analytics/analytics_service.dart';
import 'package:autojidelna/src/types/all.dart';
import 'package:autojidelna/src/ui/widgets/snackbars/show_internet_connection_snack_bar.dart';
import 'package:canteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void pressed(BuildContext context, Jidlo dish, StavJidla stavJidla) async {
  final ProviderContainer container = ProviderScope.containerOf(context);
  final CanteenProvider prov = container.read(canteenProvider);
  final Uzivatel uzivatel = container.read(userProvider).user!.data;
  final Canteen canteen = App.getIt<Canteen>();
  final L10n lang = context.l10n;
  final DateTime date = dish.den;

  if (prov.ordering) return;
  prov.ordering = true;

  if (!await InternetConnectionChecker().hasConnection) {
    final bool value = await showInternetConnectionSnackBar();
    if (value && context.mounted) pressed(context, dish, stavJidla);
  }

  switch (stavJidla) {
    case StavJidla.neobjednano:
      try {
        Jidelnicek menu = await canteen.objednat(dish);
        prov.updateMenu(menu);
        AnalyticsService().addStatistic(StatisticType.order);
      } catch (e) {
        showErrorSnackBar(SnackBarOrderingErrors.dishOrdering(lang));
      }
      break;

    case StavJidla.dostupneNaBurze:
      Burza? burza = prov.getMarketplaceTypeDish(dish);

      if (burza == null) {
        showErrorSnackBar(SnackBarOrderingErrors.dishNotInMarketplace(lang));
        break;
      }

      try {
        Jidelnicek menu = await canteen.objednatZBurzy(burza);
        prov.updateMenu(menu);
        AnalyticsService().addStatistic(StatisticType.order);
      } catch (e) {
        showErrorSnackBar(SnackBarOrderingErrors.dishOrdering(lang));
      }
      break;

    case StavJidla.objednanoVyprsenaPlatnost:
      showErrorSnackBar(SnackBarOrderingErrors.dishCancellationExpired(lang));
      break;

    case StavJidla.objednanoPouzeNaBurzu:
      try {
        Jidelnicek menu = await canteen.doBurzy(dish);
        prov.updateMenu(menu);
      } catch (e) {
        showErrorSnackBar(SnackBarOrderingErrors.dishOrdering(lang));
      }
      break;

    case StavJidla.nedostupne:
      if (date.isBefore(DateTime.now())) {
        showErrorSnackBar(SnackBarOrderingErrors.dishCannotBeOrdered(lang));
        break;
      }
      if (uzivatel.kredit < dish.cena!) {
        showErrorSnackBar(SnackBarOrderingErrors.insufficientCredit(lang));
        break;
      }
      showErrorSnackBar(SnackBarOrderingErrors.dishCannotBeOrdered(lang));
      break;

    case StavJidla.objednano:
      try {
        Jidelnicek jidelnicek = await canteen.objednat(dish);
        prov.updateMenu(jidelnicek);
      } catch (e) {
        showErrorSnackBar(SnackBarOrderingErrors.cancelingOrder(lang));
      }
      break;

    case StavJidla.vlozenoNaBurze:
      try {
        Jidelnicek jidelnicek = await canteen.doBurzy(dish);
        prov.updateMenu(jidelnicek);
      } catch (e) {
        showErrorSnackBar(SnackBarOrderingErrors.addingToMarketplace(lang));
      }
      break;
  }
  if (context.mounted) container.read(userProvider).updateUserData();
  prov.ordering = false;
}

void cannotBeOrderedFix(BuildContext context, DateTime date) async {
  final ProviderContainer container = ProviderScope.containerOf(context);
  final lang = context.l10n;
  await Future.delayed(const Duration(milliseconds: 200));
  try {
    if (!date.isBefore(DateTime.now()) && context.mounted) {
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
    showErrorSnackBar(SnackBarAuthErrors.connectionFailed(lang));
  }
}

StavJidla getStavJidla(BuildContext context, Jidlo dish) {
  final ProviderContainer container = ProviderScope.containerOf(context);
  if (dish.naBurze) {
    //pokud je od nás vloženo na burze, tak není potřeba kontrolovat nic jiného
    return StavJidla.vlozenoNaBurze;
  } else if (dish.objednano && dish.lzeObjednat) {
    return StavJidla.objednano;
  } else if (dish.objednano && !dish.lzeObjednat && (dish.burzaUrl == null || dish.burzaUrl!.isEmpty)) {
    //pokud nelze dát na burzu, tak už je po platnosti (nic už s tím neuděláme)
    return StavJidla.objednanoVyprsenaPlatnost;
  } else if (dish.objednano && !dish.lzeObjednat) {
    return StavJidla.objednanoPouzeNaBurzu;
  } else if (!dish.objednano && dish.lzeObjednat) {
    return StavJidla.neobjednano;
  } else if (container.read(canteenProvider).dishOnMarketplace(dish)) {
    return StavJidla.dostupneNaBurze;
  }
  return StavJidla.nedostupne;
}

bool isButtonEnabled(StavJidla stavJidla) {
  switch (stavJidla) {
    case StavJidla.nedostupne:
    case StavJidla.objednanoVyprsenaPlatnost:
      return false;
    case StavJidla.objednano:
    case StavJidla.objednanoPouzeNaBurzu:
    case StavJidla.vlozenoNaBurze:
    case StavJidla.dostupneNaBurze:
    case StavJidla.neobjednano:
      return true;
  }
}

String getObedText(BuildContext context, Jidlo dish, StavJidla stavJidla) {
  final ProviderContainer container = ProviderScope.containerOf(context);
  final lang = context.l10n;
  DateTime date = dish.den;
  Jidelnicek menu = container.read(canteenProvider).getCachedMenu(date)!;
  switch (stavJidla) {
    case StavJidla.objednano:
      return lang.cancel;
    case StavJidla.neobjednano:
      return lang.objednat;
    case StavJidla.objednanoVyprsenaPlatnost:
      return lang.nelzeZrusit;
    case StavJidla.objednanoPouzeNaBurzu:
      return lang.vlozitNaBurzu;
    case StavJidla.dostupneNaBurze:
      return lang.objednatZBurzy;
    case StavJidla.vlozenoNaBurze:
      return lang.odebratZBurzy;
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
        // TODO
        // if (analyticsEnabledGlobally && analytics != null) unawaited(FirebaseCrashlytics.instance.recordError(e, StackTrace.current));

        //hope it's not important
      }
      Uzivatel uzivatel = container.read(userProvider).user!.data;
      if (uzivatel.kredit < dish.cena! && !date.isBefore(DateTime.now())) {
        return lang.errorsInsufficientCredit;
      } else {
        return lang.nelzeObjednat;
      }
  }
}

bool getPrimaryState(StavJidla stavJidla) {
  switch (stavJidla) {
    case StavJidla.objednano:
    case StavJidla.objednanoPouzeNaBurzu:
    case StavJidla.objednanoVyprsenaPlatnost:
      return true;
    default:
      return false;
  }
}

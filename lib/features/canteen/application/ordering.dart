import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/analytics/statistic_type.dart';
import 'package:autojidelna/core/types/stav_jidla.dart';
import 'package:autojidelna/core/analytics/analytics_service.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:autojidelna/shared/snackbars/show_internet_connection_snack_bar.dart';
import 'package:autojidelna/features/canteen/application/canteen.provider.dart';

import 'package:canteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void pressed(BuildContext context, Jidlo dish, StavJidla stavJidla) async {
  final ProviderContainer container = ProviderScope.containerOf(context);
  final CanteenProvider prov = container.read(canteenProvider);
  final Uzivatel uzivatel = container.read(userProvider).user!.data;
  final Canteen canteen = container.read(currentCanteen);
  final L10n l10n = context.l10n;
  final DateTime date = dish.den;

  if (prov.ordering) return;
  prov.ordering = true;

  if (!await InternetConnectionChecker.instance.hasConnection) {
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
        showErrorSnackBar(SnackBarOrderingErrors.dishOrdering(l10n));
      }
      break;

    case StavJidla.dostupneNaBurze:
      Burza? burza = prov.getMarketplaceTypeDish(dish);

      if (burza == null) {
        showErrorSnackBar(SnackBarOrderingErrors.dishNotInMarketplace(l10n));
        break;
      }

      try {
        Jidelnicek menu = await canteen.objednatZBurzy(burza);
        prov.updateMenu(menu);
        AnalyticsService().addStatistic(StatisticType.order);
      } catch (e) {
        showErrorSnackBar(SnackBarOrderingErrors.dishOrdering(l10n));
      }
      break;

    case StavJidla.objednanoVyprsenaPlatnost:
      showErrorSnackBar(SnackBarOrderingErrors.dishCancellationExpired(l10n));
      break;

    case StavJidla.objednanoPouzeNaBurzu:
      try {
        Jidelnicek menu = await canteen.doBurzy(dish);
        prov.updateMenu(menu);
      } catch (e) {
        showErrorSnackBar(SnackBarOrderingErrors.dishOrdering(l10n));
      }
      break;

    case StavJidla.nedostupne:
      if (date.isBefore(DateTime.now())) {
        showErrorSnackBar(SnackBarOrderingErrors.dishCannotBeOrdered(l10n));
        break;
      }
      if (uzivatel.kredit < dish.cena!) {
        showErrorSnackBar(SnackBarOrderingErrors.insufficientCredit(l10n));
        break;
      }
      showErrorSnackBar(SnackBarOrderingErrors.dishCannotBeOrdered(l10n));
      break;

    case StavJidla.objednano:
      try {
        Jidelnicek jidelnicek = await canteen.objednat(dish);
        prov.updateMenu(jidelnicek);
      } catch (e) {
        showErrorSnackBar(SnackBarOrderingErrors.cancelingOrder(l10n));
      }
      break;

    case StavJidla.vlozenoNaBurze:
      try {
        Jidelnicek jidelnicek = await canteen.doBurzy(dish);
        prov.updateMenu(jidelnicek);
      } catch (e) {
        showErrorSnackBar(SnackBarOrderingErrors.addingToMarketplace(l10n));
      }
      break;
  }
  container.read(userProvider).updateUserData();
  prov.ordering = false;
}

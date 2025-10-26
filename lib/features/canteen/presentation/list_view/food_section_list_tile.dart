import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/core/types/stav_jidla.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:autojidelna/features/canteen/application/helpers.dart';
import 'package:autojidelna/features/canteen/presentation/burza_alert_dialog.dart';

import 'package:icanteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FoodSectionListTile extends StatelessWidget {
  const FoodSectionListTile({super.key, required this.title, required this.selection});
  final String title;
  final List<Jidlo> selection;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: timeOfDayFoodTitle(context, title),
      subtitle: Column(
        children: selection.asMap().entries.map((data) {
          int index = data.key;
          Jidlo dish = data.value;

          String title = (selection[index].kategorizovano?.hlavniJidlo ?? selection[index].nazev) == ''
              ? selection[index].nazev
              : (selection[index].kategorizovano?.hlavniJidlo ?? selection[index].nazev);

          return _DishListTile(dish: dish, title: title);
        }).toList(),
      ),
    );
  }

  Text timeOfDayFoodTitle(BuildContext context, String text) => Text(text.toUpperCase(), style: Theme.of(context).textTheme.titleSmall);
}

class _DishListTile extends ConsumerWidget {
  const _DishListTile({required this.dish, required this.title});
  final Jidlo dish;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    bool ordering = ref.watch(disableInteractions);

    final StavJidla stav = getStavJidla(context, dish);
    final bool enabled = !ordering && isButtonEnabled(stav);
    final bool selected = getPrimaryState(stav);
    const onTap = burzaAlertDialog;

    return ListTile(
      enabled: enabled,
      selected: selected,
      contentPadding: EdgeInsets.zero,
      selectedColor: theme.colorScheme.primary,
      titleTextStyle: theme.textTheme.bodyMedium,
      onTap: !enabled ? null : () => onTap(context, dish, stav),
      leading: RadioGroup(
        groupValue: true,
        onChanged: (_) => onTap(context, dish, stav),
        child: Radio<bool>(enabled: enabled, toggleable: true, value: selected, activeColor: theme.colorScheme.primary),
      ),
      title: Text(title),
      subtitle: _subtitle(context, dish.cena),
      trailing: _detailButton(context),
    );
  }

  Text? _subtitle(BuildContext context, double? price) {
    if (price == null) return null;
    return Text(NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toLanguageTag()).format(price));
  }

  IconButton _detailButton(BuildContext context) {
    return IconButton(
      onPressed: () async => context.router.navigate(DishDetailRoute(dish: dish)),
      icon: Icon(Icons.info_outline, color: Theme.of(context).listTileTheme.subtitleTextStyle!.color, size: 24),
    );
  }
}

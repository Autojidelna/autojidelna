import 'package:autojidelna/features/canteen/application/canteen.provider.dart';
import 'package:autojidelna/features/canteen/application/get_obed_text.dart';
import 'package:autojidelna/features/canteen/application/helpers.dart';
import 'package:autojidelna/features/canteen/presentation/burza_alert_dialog.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';

import 'package:icanteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderDishButton extends ConsumerWidget {
  const OrderDishButton(this.dish, {super.key});
  final Jidlo dish;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    CanteenProvider canteen = ref.watch(canteenProvider);
    bool enabled = !ref.watch(disableInteractions);

    Jidelnicek? menu = canteen.getCachedMenu(dish.datum);
    Jidlo updatedDish = menu!.nabidka.firstWhere((j) => j.varianta == dish.varianta);
    bool isPrimary = getPrimaryState(dish.stav);

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: isPrimary ? colorScheme.primary : colorScheme.secondary,
          foregroundColor: isPrimary ? colorScheme.onPrimary : colorScheme.onSecondary,
        ),
        onPressed: enabled || !isButtonEnabled(dish.stav) ? null : () => burzaAlertDialog(context, ref, updatedDish),
        child: Text(getObedText(context, ref, updatedDish)),
      ),
    );
  }
}

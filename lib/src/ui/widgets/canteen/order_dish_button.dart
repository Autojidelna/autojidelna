import 'package:autojidelna/features/canteen/application/canteen.provider.dart';
import 'package:autojidelna/features/canteen/application/ordering.dart';
import 'package:autojidelna/core/types/stav_jidla.dart';
import 'package:autojidelna/src/ui/widgets/canteen/burza_alert_dialog.dart';
import 'package:canteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderDishButton extends ConsumerWidget {
  const OrderDishButton(this.dish, {super.key});
  final Jidlo dish;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    CanteenProvider canteen = ref.watch(canteenProvider);

    Jidelnicek? menu = canteen.getCachedMenu(dish.den);
    Jidlo updatedDish = menu!.jidla.firstWhere((j) => j.varianta == dish.varianta);
    StavJidla stav = getStavJidla(context, updatedDish);
    bool isPrimary = getPrimaryState(stav);

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: isPrimary ? colorScheme.primary : colorScheme.secondary,
          foregroundColor: isPrimary ? colorScheme.onPrimary : colorScheme.onSecondary,
        ),
        onPressed: canteen.ordering || !isButtonEnabled(stav) ? null : () => burzaAlertDialog(context, updatedDish, stav),
        child: Text(getObedText(context, updatedDish, stav)),
      ),
    );
  }
}

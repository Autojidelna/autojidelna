import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';
import 'package:autojidelna/shared/utils/datetime_utils.dart';

import 'package:icanteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String getObedText(BuildContext context, WidgetRef ref, Jidlo dish) {
  final l10n = context.l10n;
  DateTime date = dish.datum;
  switch (dish.stav) {
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
      final double? cena = dish.cena;
      if (kredit != null && cena != null && kredit < cena && !date.normalize.isBefore(DateTime.now().normalize)) {
        return l10n.errorsInsufficientCredit;
      } else {
        return l10n.nelzeObjednat;
      }
    case StavJidla.verejne:
      return '';
  }
}

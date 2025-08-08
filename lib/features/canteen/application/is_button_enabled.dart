import 'package:autojidelna/core/types/stav_jidla.dart';

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

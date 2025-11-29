import 'package:icanteenlib/canteenlib.dart';

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

bool isButtonEnabled(StavJidla stavJidla) {
  switch (stavJidla) {
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

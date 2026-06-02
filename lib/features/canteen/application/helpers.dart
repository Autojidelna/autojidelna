import 'package:icanteenlib/canteenlib.dart';

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

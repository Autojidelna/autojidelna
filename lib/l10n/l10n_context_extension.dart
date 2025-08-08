import 'package:flutter/material.dart';
import 'package:autojidelna/l10n/output/l10n.dart';

export 'package:autojidelna/l10n/output/l10n.dart';

extension AppLocalizationsX on BuildContext {
  L10n get l10n => L10n.of(this);
}

import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/snackbars/info_snack_bar.dart';
import 'package:flutter/material.dart';

SnackBar loginSuccessSnackBar(BuildContext context, String username) {
  return infoSnackBar(
    context,
    icon: Icons.check_circle_outline,
    title: context.l10n.loginSuccess,
    subtitle: context.l10n.loginSuccessSubtitle(username),
  );
}

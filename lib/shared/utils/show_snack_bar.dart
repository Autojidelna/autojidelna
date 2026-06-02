import 'dart:async';

import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/core/types/freezed/snack_bar_error_data/snack_bar_data.dart';
import 'package:autojidelna/shared/snackbars/error_snack_bar.dart';
import 'package:autojidelna/shared/snackbars/info_snack_bar.dart';
import 'package:autojidelna/shared/snackbars/login_success_snack_bar.dart';
import 'package:flutter/material.dart';

void _showSnackBar(SnackBar snackbar) {
  ScaffoldMessengerState? state = App.scaffoldMessenger.currentState;
  unawaited(state?.showSnackBar(snackbar).closed.then((SnackBarClosedReason reason) {}));
}

void showErrorSnackBar(SnackBarData errorData) {
  BuildContext? ctx = App.scaffoldMessenger.currentContext;
  if (ctx == null) return;

  _showSnackBar(errorSnackBar(ctx, icon: errorData.iconData, title: errorData.title, subtitle: errorData.subtitle));
}

void showInfoSnackBar(SnackBarData infoData) {
  BuildContext? ctx = App.scaffoldMessenger.currentContext;
  if (ctx == null) return;

  _showSnackBar(infoSnackBar(ctx, icon: infoData.iconData, title: infoData.title, subtitle: infoData.subtitle));
}

void showLoginSuccessSnackBar(String username) {
  BuildContext? ctx = App.scaffoldMessenger.currentContext;
  if (ctx == null) return;

  _showSnackBar(loginSuccessSnackBar(ctx, username));
}

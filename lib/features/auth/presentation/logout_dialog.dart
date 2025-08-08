import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget logoutDialog(SafeAccount safeAccount) {
  return Builder(
    builder: (context) {
      final L10n l10n = context.l10n;
      return AlertDialog(
        title: Text(l10n.logoutUSure),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        alignment: Alignment.bottomCenter,
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await ProviderScope.containerOf(context).read(userProvider).logout(safeAccount);
              if (context.mounted) context.router.replaceAll([const RouterRoute()], updateExistingRoutes: false);
            },
            child: Text(l10n.logoutConfirm),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: Theme.of(context).textButtonTheme.style!.copyWith(foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary)),
            child: Text(l10n.cancel),
          ),
        ],
      );
    },
  );
}

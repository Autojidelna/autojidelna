import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/types/freezed/snack_bar_data.dart';
import 'package:flutter/material.dart';

class SnackBarAuthErrors {
  static SnackBarData accountNotFound(L10n l10n) =>
      SnackBarData(iconData: Icons.person_off_outlined, title: l10n.errorsAccountNotFound, subtitle: l10n.errorsAccountNotFoundSubtitle);
  static SnackBarData connectionFailed(L10n l10n) =>
      SnackBarData(iconData: Icons.cloud_off_rounded, title: l10n.errorsConnectionFailed, subtitle: l10n.errorsConnectionFailedSubtitle);
  static SnackBarData gotInternetConnection(L10n l10n) =>
      SnackBarData(iconData: Icons.wifi_rounded, title: l10n.errorsGotInternetConnection, subtitle: l10n.errorsGotInternetConnectionSubtitle);
  static SnackBarData noInternetConnection(L10n l10n) =>
      SnackBarData(iconData: Icons.wifi_off_rounded, title: l10n.errorsNoInternetConnection, subtitle: l10n.errorsNoInternetConnectionSubtitle);
  static SnackBarData wrongCredentials(L10n l10n) =>
      SnackBarData(iconData: Icons.lock_outline_rounded, title: l10n.errorsWrongCredentials, subtitle: l10n.errorsWrongCredentialsSubtitle);
  static SnackBarData wrongUrl(L10n l10n) =>
      SnackBarData(iconData: Icons.link_off_rounded, title: l10n.errorsWrongUrl, subtitle: l10n.errorsWrongUrlSubtitle);
}

class SnackBarOrderingErrors {
  static SnackBarData addingToMarketplace(L10n l10n) =>
      SnackBarData(iconData: Icons.warning_amber_rounded, title: l10n.errorsAddingToMarketplace, subtitle: l10n.errorsAddingToMarketplaceSubtitle);
  static SnackBarData cancelingOrder(L10n l10n) =>
      SnackBarData(iconData: Icons.cancel_presentation_rounded, title: l10n.errorsCancelingOrder, subtitle: l10n.errorsCancelingOrderSubtitle);
  static SnackBarData dishNotInMarketplace(L10n l10n) =>
      SnackBarData(iconData: Icons.search_off_rounded, title: l10n.errorsDishNotInMarketplace, subtitle: l10n.errorsDishNotInMarketplaceSubtitle);
  static SnackBarData menuLoadingFailed(L10n l10n) =>
      SnackBarData(iconData: Icons.warning_amber_rounded, title: l10n.errorsMenuLoadingFailed, subtitle: l10n.errorsMenuLoadingFailedSubtitle);
  static SnackBarData dishCannotBeOrdered(L10n l10n) =>
      SnackBarData(iconData: Icons.block_rounded, title: l10n.errorsDishCannotBeOrdered, subtitle: l10n.errorsDishCannotBeOrderedSubtitle);
  static SnackBarData insufficientCredit(L10n l10n) => SnackBarData(
    iconData: Icons.account_balance_wallet_outlined,
    title: l10n.errorsInsufficientCredit,
    subtitle: l10n.errorsInsufficientCreditSubtitle,
  );
  static SnackBarData dishCancellationExpired(L10n l10n) => SnackBarData(
    iconData: Icons.hourglass_bottom_rounded,
    title: l10n.errorsDishCancellationExpired,
    subtitle: l10n.errorsDishCancellationExpiredSubtitle,
  );
  static SnackBarData dishOrdering(L10n l10n) =>
      SnackBarData(iconData: Icons.restaurant_menu_rounded, title: l10n.errorsDishOrdering, subtitle: l10n.errorsDishOrderingSubtitle);
}

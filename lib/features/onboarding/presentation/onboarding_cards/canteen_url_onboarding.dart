import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/analytics/analytics_service.dart';
import 'package:autojidelna/core/types/freezed/account/account.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:autojidelna/shared/widgets/divider_with_text.dart';
import 'package:autojidelna/shared/snackbars/show_internet_connection_snack_bar.dart';
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';
import 'package:autojidelna/features/onboarding/application/onboarding_providers.dart';
import 'package:autojidelna/features/onboarding/presentation/widgets/canteen_url_picker.dart';
import 'package:autojidelna/features/onboarding/presentation/widgets/custom_url_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CanteenUrlOnboarding extends StatelessWidget implements OnboardingStep {
  const CanteenUrlOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const CustomUrlField(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DividerWithText(text: context.l10n.or),
          ),
          ConstrainedBox(constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * .4), child: const CanteenUrlPicker()),
        ],
      ),
    );
  }

  @override
  Future<bool> onPreviousPage(BuildContext context, WidgetRef ref) async {
    ref.invalidate(formKeyProvider(FormKeys.url));
    ref.invalidate(textFieldControllerProvider(OnboardingFields.url));
    ref.invalidate(textFieldProvider(OnboardingFields.url));
    return true;
  }

  @override
  Future<bool> onNextPage(BuildContext context, WidgetRef ref) async {
    final formKey = ref.read(formKeyProvider(FormKeys.url));
    final disableInteractionsNotifier = ref.read(disableInteractions.notifier);

    if (!formKey.currentState!.validate()) return false;
    formKey.currentState!.save();

    for (var field in OnboardingFields.values) {
      ref.read(textFieldProvider(field).notifier).setError(null);
    }

    disableInteractionsNotifier.state = true;
    bool allowNextPage = false;

    final Account account = Account(
      username: ref.read(textFieldProvider(OnboardingFields.username)).value!,
      password: ref.read(textFieldProvider(OnboardingFields.password)).value!,
      url: ref.read(textFieldProvider(OnboardingFields.url)).value!,
    );

    try {
      await ref.read(userProvider).login(account);
      allowNextPage = true;
    } catch (e) {
      switch (e) {
        case AuthErrors.noInternetConnection:
          if (await showInternetConnectionSnackBar() && context.mounted) onNextPage(context, ref);
          break;
        case AuthErrors.connectionFailed:
          if (context.mounted) showErrorSnackBar(SnackBarAuthErrors.connectionFailed(context.l10n));
          break;
        case AuthErrors.wrongUrl:
          if (context.mounted) {
            ref.read(textFieldProvider(OnboardingFields.url).notifier).setError(context.l10n.errorsWrongUrl);
          }
          break;
        default:
      }
    }

    AnalyticsService.instance.logCanteenUrl(ref.read(textFieldProvider(OnboardingFields.url)).value!, ref.read(currentCanteen).verze);
    disableInteractionsNotifier.state = false;
    return allowNextPage;
  }

  @override
  String buttonText(BuildContext context) => context.l10n.next;

  @override
  String description(BuildContext context) => context.l10n.loginSubtitle;
}

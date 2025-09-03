import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/analytics/presentation/analytics_switches.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:autojidelna/features/onboarding/presentation/widgets/request_notification_permission.dart';
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PermissionsOnboarding extends StatelessWidget implements OnboardingStep {
  const PermissionsOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RequestNotificationPermission(),
          CustomDivider(isTransparent: false),
          AnalyticsSwitches(),
        ],
      ),
    );
  }

  @override
  Future<bool> onPreviousPage(BuildContext context, WidgetRef ref) async => true;

  @override
  Future<bool> onNextPage(BuildContext context, WidgetRef ref) async => true;

  @override
  String buttonText(BuildContext context) => context.l10n.next;

  @override
  String description(BuildContext context) => context.l10n.onboardingSubtitle;
}

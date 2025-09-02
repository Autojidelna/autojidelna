import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:autojidelna/shared/theme/presentation/theme_mode_picker.dart';
import 'package:autojidelna/shared/theme/presentation/theme_style_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeOnboarding extends StatelessWidget implements OnboardingStep {
  const ThemeOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: ThemeModePicker(),
        ),
        CustomDivider(height: 26),
        ThemeStylePicker(),
        CustomDivider(height: 32),
      ],
    );
  }

  @override
  Future<bool> onNextPage(BuildContext context, WidgetRef ref) async => true;

  @override
  String buttonText(BuildContext context) => context.l10n.next;

  @override
  String description(BuildContext context) => context.l10n.onboardingSubtitle;
}

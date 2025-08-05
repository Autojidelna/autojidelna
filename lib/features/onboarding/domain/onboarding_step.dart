import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class OnboardingStep {
  /// Executes before going to the next page, returns true if successful
  Future<bool> onNextPage(BuildContext context, {WidgetRef ref});

  /// Used as the subtitle for the current step above the card
  String description(BuildContext context);

  /// String used on the 'next page' button
  String buttonText(BuildContext context);
}

mixin OnboardingStepMixin on StatefulWidget {
  Future<bool> onNextPage(BuildContext context, {WidgetRef ref});
  String description(BuildContext context);
  String buttonText(BuildContext context);
}

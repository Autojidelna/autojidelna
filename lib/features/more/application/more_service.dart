import 'package:autojidelna/core/types/freezed/user/user.dart';
import 'package:autojidelna/features/onboarding/onboarding.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/features/auth/presentation/switch_account_panel.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([onboardingFormKey, OnboardingTextFieldState, OnboardingSteps, OnboardingFocusNodeFocus])
class MoreService {
  MoreService(this.user);
  final User? user;

  void openSwitchAccountPannel(BuildContext context) => SwitchAccountPanel.open(context);
}

@Dependencies([onboardingFormKey, OnboardingTextFieldState, OnboardingSteps, OnboardingFocusNodeFocus])
final moreServiceProvider = Provider<MoreService>((ref) {
  final user = ref.watch(userProvider.select((it) => (it.user)));

  return MoreService(user);
});

import 'package:autojidelna/shared/providers/text_fields/text_field_state.dart';
import 'package:autojidelna/features/onboarding/onboarding.dart';
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';

import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_providers.g.dart';

enum OnboardingFormKeys { url, credentials }

enum OnboardingTextFields { url, username, password }

@Riverpod(keepAlive: true, dependencies: [])
GlobalKey<FormState> onboardingFormKey(Ref ref, OnboardingFormKeys formKey) => GlobalKey<FormState>();

@Riverpod(dependencies: [])
class OnboardingFocusNodeFocus extends _$OnboardingFocusNodeFocus {
  @override
  bool build(OnboardingTextFields fieldKey) => false;

  void set(bool hasFocus) => state = hasFocus;
}

@Riverpod(dependencies: [OnboardingFocusNodeFocus])
bool onboardingHasFocus(Ref ref) => OnboardingTextFields.values.any((field) {
      final hasFocus = OnboardingTextFields.values.any((field) => ref.watch(onboardingFocusNodeFocusProvider(field)));
      return hasFocus;
    });

@Riverpod(keepAlive: true, dependencies: [])
class OnboardingTextFieldState extends _$OnboardingTextFieldState {
  @override
  TextFieldState build(OnboardingTextFields fieldKey) => const TextFieldState(value: '');

  void setValue(String? value) => state = state.copyWith(value: value);
  void setError(String? error) => state = state.copyWith(error: error);
  void toggleObscure() => state = state.copyWith(obscureText: !state.obscureText);
}

@Riverpod(keepAlive: true, dependencies: [])
List<OnboardingStep> onboardingInitialSteps(Ref ref) => Onboarding.defaultSteps;

@Riverpod(keepAlive: true, dependencies: [])
class OnboardingSteps extends _$OnboardingSteps {
  @override
  List<OnboardingStep> build() => ref.read(onboardingInitialStepsProvider);

  void addLoginPages() {
    state.addAll(Onboarding.loginSteps);
    ref.notifyListeners();
  }

  void addAccountPickerPages() {
    state.addAll(Onboarding.accountPickerSteps);
    ref.notifyListeners();
  }

  void setLoginFlow() {
    state = Onboarding.loginSteps;
    ref.notifyListeners();
  }

  void setAccountPickerFlow() {
    state = Onboarding.accountPickerSteps;
    ref.notifyListeners();
  }

  void removeLoginPages() {
    state = state.where((step) => !Onboarding.loginSteps.contains(step)).toList();
    ref.notifyListeners();
  }
}

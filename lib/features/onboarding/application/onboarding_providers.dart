import 'package:autojidelna/shared/providers/text_fields/text_field_state.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  set state(bool newState) => super.state = newState;
  bool update(bool Function(bool state) cb) => state = cb(state);
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

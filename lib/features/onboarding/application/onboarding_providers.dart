import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/shared/providers/text_fields/text_field_state.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive/hive.dart';

part 'onboarding_providers.g.dart';

enum OnboardingFormKeys { url, credentials }

enum OnboardingTextFields { url, username, password }

@Riverpod(keepAlive: true)
GlobalKey<FormState> onboardingFormKey(Ref ref, OnboardingFormKeys formKey) => GlobalKey<FormState>();

@Riverpod(keepAlive: true)
Raw<TextEditingController> onboardingTextFieldController(Ref ref, OnboardingTextFields fieldKey) {
  String? initialValue = fieldKey == OnboardingTextFields.url ? Hive.box(Boxes.appState).get(HiveKeys.appState.url) : null;
  final controller = TextEditingController(text: initialValue);
  ref.onDispose(controller.dispose);
  return controller;
}

// TODO: think of a nice way to update this to 2.0.0+ annotation
final onboardingFocusNodeProvider = ChangeNotifierProvider.family<FocusNode, OnboardingTextFields>((ref, field) {
  final node = FocusNode();
  ref.onDispose(node.dispose);
  return node;
});

final onboardingHasFocusProvider = Provider<bool>((Ref ref) {
  return OnboardingTextFields.values.any((field) => ref.watch(onboardingFocusNodeProvider(field)).hasFocus);
});

@Riverpod(keepAlive: true)
class OnboardingTextFieldState extends _$OnboardingTextFieldState {
  @override
  TextFieldState build(OnboardingTextFields fieldKey) => const TextFieldState(value: '');

  void setValue(String? value) => state = state.copyWith(value: value);
  void setError(String? error) => state = state.copyWith(error: error);
  void toggleObscure() => state = state.copyWith(obscureText: !state.obscureText);
}

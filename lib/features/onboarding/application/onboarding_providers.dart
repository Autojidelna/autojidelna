import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/shared/providers/text_fields/text_field_state.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

enum OnboardingFormKeys { url, credentials }

enum OnboardingTextFields { url, username, password }

final formKeyProvider = Provider.family<GlobalKey<FormState>, OnboardingFormKeys>((ref, formName) => GlobalKey<FormState>());

final textFieldControllerProvider = Provider.family<TextEditingController, OnboardingTextFields>((ref, fieldKey) {
  String? initialValue = fieldKey == OnboardingTextFields.url ? Hive.box(Boxes.appState).get(HiveKeys.appState.url) : null;
  final controller = TextEditingController(text: initialValue);
  ref.onDispose(controller.dispose);

  return controller;
});

final focusNodeProvider = ChangeNotifierProvider.family<FocusNode, OnboardingTextFields>((ref, field) {
  final node = FocusNode();
  ref.onDispose(node.dispose);
  return node;
});

final isAnyFocusedProvider = Provider<bool>((ref) {
  return OnboardingTextFields.values.any((field) => ref.watch(focusNodeProvider(field)).hasFocus);
});

final textFieldProvider =
    StateNotifierProvider.family<TextFieldNotifier, TextFieldState, OnboardingTextFields>((ref, fieldKey) => TextFieldNotifier());

class TextFieldNotifier extends StateNotifier<TextFieldState> {
  TextFieldNotifier({String? initialValue}) : super(TextFieldState(value: initialValue ?? ''));

  void setValue(String? value) => state = state.copyWith(value: value);
  void setError(String? error) => state = state.copyWith(error: error);
  void toggleObscure() => state = state.copyWith(obscureText: !state.obscureText);
}

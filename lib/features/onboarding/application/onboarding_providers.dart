import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/providers/text_fields/text_field_state.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

enum FormKeys { url, credentials }

enum OnboardingFields { url, username, password }

final formKeyProvider = Provider.family<GlobalKey<FormState>, FormKeys>((ref, formName) => GlobalKey<FormState>());

final textFieldControllerProvider = Provider.family<TextEditingController, OnboardingFields>((ref, fieldKey) {
  String? initialValue = fieldKey == OnboardingFields.url ? Hive.box(Boxes.appState).get(HiveKeys.appState.url) : null;
  final controller = TextEditingController(text: initialValue);
  ref.onDispose(controller.dispose);

  return controller;
});

final isAnyFocusedProvider = Provider<bool>((ref) {
  return OnboardingFields.values.any((field) => ref.watch(focusNodeProvider(field)).hasFocus);
});

final focusNodeProvider = ChangeNotifierProvider.family<FocusNode, OnboardingFields>((ref, field) {
  final node = FocusNode();
  ref.onDispose(node.dispose);
  return node;
});

final textFieldProvider = StateNotifierProvider.family<TextFieldNotifier, TextFieldState, OnboardingFields>((ref, fieldKey) => TextFieldNotifier());

class TextFieldNotifier extends StateNotifier<TextFieldState> {
  TextFieldNotifier({String? initialValue}) : super(TextFieldState(value: initialValue ?? ''));

  void setValue(String? value) => state = state.copyWith(value: value);
  void setError(String? error) => state = state.copyWith(error: error);
  void toggleObscure() => state = state.copyWith(obscureText: !state.obscureText);
}

final selectedSafeAccount = StateProvider.autoDispose<SafeAccount>((ref) => ref.read(userProvider).loggedInAccounts.first);

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(onboardingFormKey)
final onboardingFormKeyProvider = OnboardingFormKeyFamily._();

final class OnboardingFormKeyProvider
    extends
        $FunctionalProvider<
          GlobalKey<FormState>,
          GlobalKey<FormState>,
          GlobalKey<FormState>
        >
    with $Provider<GlobalKey<FormState>> {
  OnboardingFormKeyProvider._({
    required OnboardingFormKeyFamily super.from,
    required OnboardingFormKeys super.argument,
  }) : super(
         retry: null,
         name: r'onboardingFormKeyProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$onboardingFormKeyHash();

  @override
  String toString() {
    return r'onboardingFormKeyProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<GlobalKey<FormState>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GlobalKey<FormState> create(Ref ref) {
    final argument = this.argument as OnboardingFormKeys;
    return onboardingFormKey(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GlobalKey<FormState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GlobalKey<FormState>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is OnboardingFormKeyProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$onboardingFormKeyHash() => r'8986a8124ec65afd7aa67d00146a89becb48da20';

final class OnboardingFormKeyFamily extends $Family
    with $FunctionalFamilyOverride<GlobalKey<FormState>, OnboardingFormKeys> {
  OnboardingFormKeyFamily._()
    : super(
        retry: null,
        name: r'onboardingFormKeyProvider',
        dependencies: <ProviderOrFamily>[],
        $allTransitiveDependencies: <ProviderOrFamily>[],
        isAutoDispose: false,
      );

  OnboardingFormKeyProvider call(OnboardingFormKeys formKey) =>
      OnboardingFormKeyProvider._(argument: formKey, from: this);

  @override
  String toString() => r'onboardingFormKeyProvider';
}

@ProviderFor(OnboardingFocusNodeFocus)
final onboardingFocusNodeFocusProvider = OnboardingFocusNodeFocusFamily._();

final class OnboardingFocusNodeFocusProvider
    extends $NotifierProvider<OnboardingFocusNodeFocus, bool> {
  OnboardingFocusNodeFocusProvider._({
    required OnboardingFocusNodeFocusFamily super.from,
    required OnboardingTextFields super.argument,
  }) : super(
         retry: null,
         name: r'onboardingFocusNodeFocusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$onboardingFocusNodeFocusHash();

  @override
  String toString() {
    return r'onboardingFocusNodeFocusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  OnboardingFocusNodeFocus create() => OnboardingFocusNodeFocus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is OnboardingFocusNodeFocusProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$onboardingFocusNodeFocusHash() =>
    r'5ba3e443105f903f88d01a27cb810484705e91ad';

final class OnboardingFocusNodeFocusFamily extends $Family
    with
        $ClassFamilyOverride<
          OnboardingFocusNodeFocus,
          bool,
          bool,
          bool,
          OnboardingTextFields
        > {
  OnboardingFocusNodeFocusFamily._()
    : super(
        retry: null,
        name: r'onboardingFocusNodeFocusProvider',
        dependencies: <ProviderOrFamily>[],
        $allTransitiveDependencies: <ProviderOrFamily>[],
        isAutoDispose: true,
      );

  OnboardingFocusNodeFocusProvider call(OnboardingTextFields fieldKey) =>
      OnboardingFocusNodeFocusProvider._(argument: fieldKey, from: this);

  @override
  String toString() => r'onboardingFocusNodeFocusProvider';
}

abstract class _$OnboardingFocusNodeFocus extends $Notifier<bool> {
  late final _$args = ref.$arg as OnboardingTextFields;
  OnboardingTextFields get fieldKey => _$args;

  bool build(OnboardingTextFields fieldKey);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(onboardingHasFocus)
final onboardingHasFocusProvider = OnboardingHasFocusProvider._();

final class OnboardingHasFocusProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  OnboardingHasFocusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingHasFocusProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[onboardingFocusNodeFocusProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          OnboardingHasFocusProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = onboardingFocusNodeFocusProvider;

  @override
  String debugGetCreateSourceHash() => _$onboardingHasFocusHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return onboardingHasFocus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$onboardingHasFocusHash() =>
    r'7887a8eff8e7bc32e33283420074b651a7d83428';

@ProviderFor(OnboardingTextFieldState)
final onboardingTextFieldStateProvider = OnboardingTextFieldStateFamily._();

final class OnboardingTextFieldStateProvider
    extends $NotifierProvider<OnboardingTextFieldState, TextFieldState> {
  OnboardingTextFieldStateProvider._({
    required OnboardingTextFieldStateFamily super.from,
    required OnboardingTextFields super.argument,
  }) : super(
         retry: null,
         name: r'onboardingTextFieldStateProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$onboardingTextFieldStateHash();

  @override
  String toString() {
    return r'onboardingTextFieldStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  OnboardingTextFieldState create() => OnboardingTextFieldState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TextFieldState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TextFieldState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is OnboardingTextFieldStateProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$onboardingTextFieldStateHash() =>
    r'328c438b0bb0328c467b974dfd45880fea864246';

final class OnboardingTextFieldStateFamily extends $Family
    with
        $ClassFamilyOverride<
          OnboardingTextFieldState,
          TextFieldState,
          TextFieldState,
          TextFieldState,
          OnboardingTextFields
        > {
  OnboardingTextFieldStateFamily._()
    : super(
        retry: null,
        name: r'onboardingTextFieldStateProvider',
        dependencies: <ProviderOrFamily>[],
        $allTransitiveDependencies: <ProviderOrFamily>[],
        isAutoDispose: false,
      );

  OnboardingTextFieldStateProvider call(OnboardingTextFields fieldKey) =>
      OnboardingTextFieldStateProvider._(argument: fieldKey, from: this);

  @override
  String toString() => r'onboardingTextFieldStateProvider';
}

abstract class _$OnboardingTextFieldState extends $Notifier<TextFieldState> {
  late final _$args = ref.$arg as OnboardingTextFields;
  OnboardingTextFields get fieldKey => _$args;

  TextFieldState build(OnboardingTextFields fieldKey);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TextFieldState, TextFieldState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TextFieldState, TextFieldState>,
              TextFieldState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(onboardingInitialSteps)
final onboardingInitialStepsProvider = OnboardingInitialStepsProvider._();

final class OnboardingInitialStepsProvider
    extends
        $FunctionalProvider<
          List<OnboardingStep>,
          List<OnboardingStep>,
          List<OnboardingStep>
        >
    with $Provider<List<OnboardingStep>> {
  OnboardingInitialStepsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingInitialStepsProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[],
        $allTransitiveDependencies: <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingInitialStepsHash();

  @$internal
  @override
  $ProviderElement<List<OnboardingStep>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<OnboardingStep> create(Ref ref) {
    return onboardingInitialSteps(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<OnboardingStep> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<OnboardingStep>>(value),
    );
  }
}

String _$onboardingInitialStepsHash() =>
    r'831b02ad64738a6f21220f27b7617fc65d494997';

@ProviderFor(OnboardingSteps)
final onboardingStepsProvider = OnboardingStepsProvider._();

final class OnboardingStepsProvider
    extends $NotifierProvider<OnboardingSteps, List<OnboardingStep>> {
  OnboardingStepsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingStepsProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[onboardingInitialStepsProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          OnboardingStepsProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = onboardingInitialStepsProvider;

  @override
  String debugGetCreateSourceHash() => _$onboardingStepsHash();

  @$internal
  @override
  OnboardingSteps create() => OnboardingSteps();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<OnboardingStep> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<OnboardingStep>>(value),
    );
  }
}

String _$onboardingStepsHash() => r'a5c6d69b27ae291b6a1889641f04d215a21e7042';

abstract class _$OnboardingSteps extends $Notifier<List<OnboardingStep>> {
  List<OnboardingStep> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<OnboardingStep>, List<OnboardingStep>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<OnboardingStep>, List<OnboardingStep>>,
              List<OnboardingStep>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

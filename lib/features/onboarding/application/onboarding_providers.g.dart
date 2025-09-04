// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onboardingFormKeyHash() => r'8986a8124ec65afd7aa67d00146a89becb48da20';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [onboardingFormKey].
@ProviderFor(onboardingFormKey)
const onboardingFormKeyProvider = OnboardingFormKeyFamily();

/// See also [onboardingFormKey].
class OnboardingFormKeyFamily extends Family<GlobalKey<FormState>> {
  /// See also [onboardingFormKey].
  const OnboardingFormKeyFamily();

  /// See also [onboardingFormKey].
  OnboardingFormKeyProvider call(
    OnboardingFormKeys formKey,
  ) {
    return OnboardingFormKeyProvider(
      formKey,
    );
  }

  @override
  OnboardingFormKeyProvider getProviderOverride(
    covariant OnboardingFormKeyProvider provider,
  ) {
    return call(
      provider.formKey,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies =
      const <ProviderOrFamily>[];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      const <ProviderOrFamily>{};

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'onboardingFormKeyProvider';
}

/// See also [onboardingFormKey].
class OnboardingFormKeyProvider extends Provider<GlobalKey<FormState>> {
  /// See also [onboardingFormKey].
  OnboardingFormKeyProvider(
    OnboardingFormKeys formKey,
  ) : this._internal(
          (ref) => onboardingFormKey(
            ref as OnboardingFormKeyRef,
            formKey,
          ),
          from: onboardingFormKeyProvider,
          name: r'onboardingFormKeyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onboardingFormKeyHash,
          dependencies: OnboardingFormKeyFamily._dependencies,
          allTransitiveDependencies:
              OnboardingFormKeyFamily._allTransitiveDependencies,
          formKey: formKey,
        );

  OnboardingFormKeyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.formKey,
  }) : super.internal();

  final OnboardingFormKeys formKey;

  @override
  Override overrideWith(
    GlobalKey<FormState> Function(OnboardingFormKeyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OnboardingFormKeyProvider._internal(
        (ref) => create(ref as OnboardingFormKeyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        formKey: formKey,
      ),
    );
  }

  @override
  ProviderElement<GlobalKey<FormState>> createElement() {
    return _OnboardingFormKeyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnboardingFormKeyProvider && other.formKey == formKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, formKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnboardingFormKeyRef on ProviderRef<GlobalKey<FormState>> {
  /// The parameter `formKey` of this provider.
  OnboardingFormKeys get formKey;
}

class _OnboardingFormKeyProviderElement
    extends ProviderElement<GlobalKey<FormState>> with OnboardingFormKeyRef {
  _OnboardingFormKeyProviderElement(super.provider);

  @override
  OnboardingFormKeys get formKey =>
      (origin as OnboardingFormKeyProvider).formKey;
}

String _$onboardingHasFocusHash() =>
    r'af0e441ed5dfcb57d4b5ce7bae2581097b42f41d';

/// See also [onboardingHasFocus].
@ProviderFor(onboardingHasFocus)
final onboardingHasFocusProvider = AutoDisposeProvider<bool>.internal(
  onboardingHasFocus,
  name: r'onboardingHasFocusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingHasFocusHash,
  dependencies: <ProviderOrFamily>[onboardingFocusNodeFocusProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    onboardingFocusNodeFocusProvider,
    ...?onboardingFocusNodeFocusProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnboardingHasFocusRef = AutoDisposeProviderRef<bool>;
String _$onboardingInitialStepsHash() =>
    r'831b02ad64738a6f21220f27b7617fc65d494997';

/// See also [onboardingInitialSteps].
@ProviderFor(onboardingInitialSteps)
final onboardingInitialStepsProvider = Provider<List<OnboardingStep>>.internal(
  onboardingInitialSteps,
  name: r'onboardingInitialStepsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingInitialStepsHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnboardingInitialStepsRef = ProviderRef<List<OnboardingStep>>;
String _$onboardingFocusNodeFocusHash() =>
    r'5ba3e443105f903f88d01a27cb810484705e91ad';

abstract class _$OnboardingFocusNodeFocus
    extends BuildlessAutoDisposeNotifier<bool> {
  late final OnboardingTextFields fieldKey;

  bool build(
    OnboardingTextFields fieldKey,
  );
}

/// See also [OnboardingFocusNodeFocus].
@ProviderFor(OnboardingFocusNodeFocus)
const onboardingFocusNodeFocusProvider = OnboardingFocusNodeFocusFamily();

/// See also [OnboardingFocusNodeFocus].
class OnboardingFocusNodeFocusFamily extends Family<bool> {
  /// See also [OnboardingFocusNodeFocus].
  const OnboardingFocusNodeFocusFamily();

  /// See also [OnboardingFocusNodeFocus].
  OnboardingFocusNodeFocusProvider call(
    OnboardingTextFields fieldKey,
  ) {
    return OnboardingFocusNodeFocusProvider(
      fieldKey,
    );
  }

  @override
  OnboardingFocusNodeFocusProvider getProviderOverride(
    covariant OnboardingFocusNodeFocusProvider provider,
  ) {
    return call(
      provider.fieldKey,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies =
      const <ProviderOrFamily>[];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      const <ProviderOrFamily>{};

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'onboardingFocusNodeFocusProvider';
}

/// See also [OnboardingFocusNodeFocus].
class OnboardingFocusNodeFocusProvider
    extends AutoDisposeNotifierProviderImpl<OnboardingFocusNodeFocus, bool> {
  /// See also [OnboardingFocusNodeFocus].
  OnboardingFocusNodeFocusProvider(
    OnboardingTextFields fieldKey,
  ) : this._internal(
          () => OnboardingFocusNodeFocus()..fieldKey = fieldKey,
          from: onboardingFocusNodeFocusProvider,
          name: r'onboardingFocusNodeFocusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onboardingFocusNodeFocusHash,
          dependencies: OnboardingFocusNodeFocusFamily._dependencies,
          allTransitiveDependencies:
              OnboardingFocusNodeFocusFamily._allTransitiveDependencies,
          fieldKey: fieldKey,
        );

  OnboardingFocusNodeFocusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fieldKey,
  }) : super.internal();

  final OnboardingTextFields fieldKey;

  @override
  bool runNotifierBuild(
    covariant OnboardingFocusNodeFocus notifier,
  ) {
    return notifier.build(
      fieldKey,
    );
  }

  @override
  Override overrideWith(OnboardingFocusNodeFocus Function() create) {
    return ProviderOverride(
      origin: this,
      override: OnboardingFocusNodeFocusProvider._internal(
        () => create()..fieldKey = fieldKey,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fieldKey: fieldKey,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<OnboardingFocusNodeFocus, bool>
      createElement() {
    return _OnboardingFocusNodeFocusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnboardingFocusNodeFocusProvider &&
        other.fieldKey == fieldKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fieldKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnboardingFocusNodeFocusRef on AutoDisposeNotifierProviderRef<bool> {
  /// The parameter `fieldKey` of this provider.
  OnboardingTextFields get fieldKey;
}

class _OnboardingFocusNodeFocusProviderElement
    extends AutoDisposeNotifierProviderElement<OnboardingFocusNodeFocus, bool>
    with OnboardingFocusNodeFocusRef {
  _OnboardingFocusNodeFocusProviderElement(super.provider);

  @override
  OnboardingTextFields get fieldKey =>
      (origin as OnboardingFocusNodeFocusProvider).fieldKey;
}

String _$onboardingTextFieldStateHash() =>
    r'328c438b0bb0328c467b974dfd45880fea864246';

abstract class _$OnboardingTextFieldState
    extends BuildlessNotifier<TextFieldState> {
  late final OnboardingTextFields fieldKey;

  TextFieldState build(
    OnboardingTextFields fieldKey,
  );
}

/// See also [OnboardingTextFieldState].
@ProviderFor(OnboardingTextFieldState)
const onboardingTextFieldStateProvider = OnboardingTextFieldStateFamily();

/// See also [OnboardingTextFieldState].
class OnboardingTextFieldStateFamily extends Family<TextFieldState> {
  /// See also [OnboardingTextFieldState].
  const OnboardingTextFieldStateFamily();

  /// See also [OnboardingTextFieldState].
  OnboardingTextFieldStateProvider call(
    OnboardingTextFields fieldKey,
  ) {
    return OnboardingTextFieldStateProvider(
      fieldKey,
    );
  }

  @override
  OnboardingTextFieldStateProvider getProviderOverride(
    covariant OnboardingTextFieldStateProvider provider,
  ) {
    return call(
      provider.fieldKey,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies =
      const <ProviderOrFamily>[];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      const <ProviderOrFamily>{};

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'onboardingTextFieldStateProvider';
}

/// See also [OnboardingTextFieldState].
class OnboardingTextFieldStateProvider
    extends NotifierProviderImpl<OnboardingTextFieldState, TextFieldState> {
  /// See also [OnboardingTextFieldState].
  OnboardingTextFieldStateProvider(
    OnboardingTextFields fieldKey,
  ) : this._internal(
          () => OnboardingTextFieldState()..fieldKey = fieldKey,
          from: onboardingTextFieldStateProvider,
          name: r'onboardingTextFieldStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onboardingTextFieldStateHash,
          dependencies: OnboardingTextFieldStateFamily._dependencies,
          allTransitiveDependencies:
              OnboardingTextFieldStateFamily._allTransitiveDependencies,
          fieldKey: fieldKey,
        );

  OnboardingTextFieldStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fieldKey,
  }) : super.internal();

  final OnboardingTextFields fieldKey;

  @override
  TextFieldState runNotifierBuild(
    covariant OnboardingTextFieldState notifier,
  ) {
    return notifier.build(
      fieldKey,
    );
  }

  @override
  Override overrideWith(OnboardingTextFieldState Function() create) {
    return ProviderOverride(
      origin: this,
      override: OnboardingTextFieldStateProvider._internal(
        () => create()..fieldKey = fieldKey,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fieldKey: fieldKey,
      ),
    );
  }

  @override
  NotifierProviderElement<OnboardingTextFieldState, TextFieldState>
      createElement() {
    return _OnboardingTextFieldStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnboardingTextFieldStateProvider &&
        other.fieldKey == fieldKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fieldKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnboardingTextFieldStateRef on NotifierProviderRef<TextFieldState> {
  /// The parameter `fieldKey` of this provider.
  OnboardingTextFields get fieldKey;
}

class _OnboardingTextFieldStateProviderElement
    extends NotifierProviderElement<OnboardingTextFieldState, TextFieldState>
    with OnboardingTextFieldStateRef {
  _OnboardingTextFieldStateProviderElement(super.provider);

  @override
  OnboardingTextFields get fieldKey =>
      (origin as OnboardingTextFieldStateProvider).fieldKey;
}

String _$onboardingStepsHash() => r'fa27a6a5271aa0c646972cfdba61c9abf2dbfa91';

/// See also [OnboardingSteps].
@ProviderFor(OnboardingSteps)
final onboardingStepsProvider =
    NotifierProvider<OnboardingSteps, List<OnboardingStep>>.internal(
  OnboardingSteps.new,
  name: r'onboardingStepsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingStepsHash,
  dependencies: <ProviderOrFamily>[onboardingInitialStepsProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    onboardingInitialStepsProvider,
    ...?onboardingInitialStepsProvider.allTransitiveDependencies
  },
);

typedef _$OnboardingSteps = Notifier<List<OnboardingStep>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

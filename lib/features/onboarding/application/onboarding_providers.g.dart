// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onboardingFormKeyHash() => r'a545dcb4cfc22cfa2828fdb76a481403d1cdedd4';

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

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

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

String _$onboardingTextFieldControllerHash() =>
    r'2bd8ada9a393e52587bdf9d7a62fe4558810b02a';

/// See also [onboardingTextFieldController].
@ProviderFor(onboardingTextFieldController)
const onboardingTextFieldControllerProvider =
    OnboardingTextFieldControllerFamily();

/// See also [onboardingTextFieldController].
class OnboardingTextFieldControllerFamily
    extends Family<Raw<TextEditingController>> {
  /// See also [onboardingTextFieldController].
  const OnboardingTextFieldControllerFamily();

  /// See also [onboardingTextFieldController].
  OnboardingTextFieldControllerProvider call(
    OnboardingTextFields fieldKey,
  ) {
    return OnboardingTextFieldControllerProvider(
      fieldKey,
    );
  }

  @override
  OnboardingTextFieldControllerProvider getProviderOverride(
    covariant OnboardingTextFieldControllerProvider provider,
  ) {
    return call(
      provider.fieldKey,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'onboardingTextFieldControllerProvider';
}

/// See also [onboardingTextFieldController].
class OnboardingTextFieldControllerProvider
    extends Provider<Raw<TextEditingController>> {
  /// See also [onboardingTextFieldController].
  OnboardingTextFieldControllerProvider(
    OnboardingTextFields fieldKey,
  ) : this._internal(
          (ref) => onboardingTextFieldController(
            ref as OnboardingTextFieldControllerRef,
            fieldKey,
          ),
          from: onboardingTextFieldControllerProvider,
          name: r'onboardingTextFieldControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onboardingTextFieldControllerHash,
          dependencies: OnboardingTextFieldControllerFamily._dependencies,
          allTransitiveDependencies:
              OnboardingTextFieldControllerFamily._allTransitiveDependencies,
          fieldKey: fieldKey,
        );

  OnboardingTextFieldControllerProvider._internal(
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
  Override overrideWith(
    Raw<TextEditingController> Function(
            OnboardingTextFieldControllerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OnboardingTextFieldControllerProvider._internal(
        (ref) => create(ref as OnboardingTextFieldControllerRef),
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
  ProviderElement<Raw<TextEditingController>> createElement() {
    return _OnboardingTextFieldControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnboardingTextFieldControllerProvider &&
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
mixin OnboardingTextFieldControllerRef
    on ProviderRef<Raw<TextEditingController>> {
  /// The parameter `fieldKey` of this provider.
  OnboardingTextFields get fieldKey;
}

class _OnboardingTextFieldControllerProviderElement
    extends ProviderElement<Raw<TextEditingController>>
    with OnboardingTextFieldControllerRef {
  _OnboardingTextFieldControllerProviderElement(super.provider);

  @override
  OnboardingTextFields get fieldKey =>
      (origin as OnboardingTextFieldControllerProvider).fieldKey;
}

String _$onboardingHasFocusHash() =>
    r'105e4b975353161855e81293438bed328938b9a5';

/// See also [OnboardingHasFocus].
@ProviderFor(OnboardingHasFocus)
final onboardingHasFocusProvider =
    AutoDisposeNotifierProvider<OnboardingHasFocus, bool>.internal(
  OnboardingHasFocus.new,
  name: r'onboardingHasFocusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingHasFocusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OnboardingHasFocus = AutoDisposeNotifier<bool>;
String _$onboardingTextFieldStateHash() =>
    r'035cdafbe31636c1c03b9e157b2f32ec45783602';

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

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

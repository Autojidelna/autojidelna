// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isBrightHash() => r'69c1be64e904f5b1231917f642b6571d890789aa';

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

/// See also [isBright].
@ProviderFor(isBright)
const isBrightProvider = IsBrightFamily();

/// See also [isBright].
class IsBrightFamily extends Family<bool> {
  /// See also [isBright].
  const IsBrightFamily();

  /// See also [isBright].
  IsBrightProvider call(
    Brightness brightness,
  ) {
    return IsBrightProvider(
      brightness,
    );
  }

  @override
  IsBrightProvider getProviderOverride(
    covariant IsBrightProvider provider,
  ) {
    return call(
      provider.brightness,
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
  String? get name => r'isBrightProvider';
}

/// See also [isBright].
class IsBrightProvider extends AutoDisposeProvider<bool> {
  /// See also [isBright].
  IsBrightProvider(
    Brightness brightness,
  ) : this._internal(
          (ref) => isBright(
            ref as IsBrightRef,
            brightness,
          ),
          from: isBrightProvider,
          name: r'isBrightProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isBrightHash,
          dependencies: IsBrightFamily._dependencies,
          allTransitiveDependencies: IsBrightFamily._allTransitiveDependencies,
          brightness: brightness,
        );

  IsBrightProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.brightness,
  }) : super.internal();

  final Brightness brightness;

  @override
  Override overrideWith(
    bool Function(IsBrightRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsBrightProvider._internal(
        (ref) => create(ref as IsBrightRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        brightness: brightness,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsBrightProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsBrightProvider && other.brightness == brightness;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, brightness.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsBrightRef on AutoDisposeProviderRef<bool> {
  /// The parameter `brightness` of this provider.
  Brightness get brightness;
}

class _IsBrightProviderElement extends AutoDisposeProviderElement<bool>
    with IsBrightRef {
  _IsBrightProviderElement(super.provider);

  @override
  Brightness get brightness => (origin as IsBrightProvider).brightness;
}

String _$themeNotifierHash() => r'462836ef773c65018fa717e3c0bfdb801408270b';

/// See also [ThemeNotifier].
@ProviderFor(ThemeNotifier)
final themeNotifierProvider =
    AutoDisposeNotifierProvider<ThemeNotifier, ThemeState>.internal(
  ThemeNotifier.new,
  name: r'themeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeNotifier = AutoDisposeNotifier<ThemeState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

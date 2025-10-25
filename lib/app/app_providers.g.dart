// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scaffoldMessenger)
const scaffoldMessengerProvider = ScaffoldMessengerProvider._();

final class ScaffoldMessengerProvider extends $FunctionalProvider<
        GlobalKey<ScaffoldMessengerState>,
        GlobalKey<ScaffoldMessengerState>,
        GlobalKey<ScaffoldMessengerState>>
    with $Provider<GlobalKey<ScaffoldMessengerState>> {
  const ScaffoldMessengerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'scaffoldMessengerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$scaffoldMessengerHash();

  @$internal
  @override
  $ProviderElement<GlobalKey<ScaffoldMessengerState>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GlobalKey<ScaffoldMessengerState> create(Ref ref) {
    return scaffoldMessenger(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GlobalKey<ScaffoldMessengerState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<GlobalKey<ScaffoldMessengerState>>(value),
    );
  }
}

String _$scaffoldMessengerHash() => r'5cfbc23cb0ff38ab348a69c0eea13ee75688f4de';

@ProviderFor(packageInfo)
const packageInfoProvider = PackageInfoProvider._();

final class PackageInfoProvider extends $FunctionalProvider<
        AsyncValue<PackageInfo>, PackageInfo, FutureOr<PackageInfo>>
    with $FutureModifier<PackageInfo>, $FutureProvider<PackageInfo> {
  const PackageInfoProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'packageInfoProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$packageInfoHash();

  @$internal
  @override
  $FutureProviderElement<PackageInfo> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<PackageInfo> create(Ref ref) {
    return packageInfo(ref);
  }
}

String _$packageInfoHash() => r'5fd12e5a46daf085d283c70a7608ea667979e1a4';

@ProviderFor(currentPatchNumber)
const currentPatchNumberProvider = CurrentPatchNumberProvider._();

final class CurrentPatchNumberProvider
    extends $FunctionalProvider<int?, int?, int?> with $Provider<int?> {
  const CurrentPatchNumberProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'currentPatchNumberProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$currentPatchNumberHash();

  @$internal
  @override
  $ProviderElement<int?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int? create(Ref ref) {
    return currentPatchNumber(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$currentPatchNumberHash() =>
    r'9e5375d76c322730ac2bae263a52919f49104ccd';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$remoteConfigHash() => r'3fc1ba80563b44eb9869a13b0684b770f2843812';

/// See also [remoteConfig].
@ProviderFor(remoteConfig)
final remoteConfigProvider = Provider<Rmc>.internal(
  remoteConfig,
  name: r'remoteConfigProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$remoteConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemoteConfigRef = ProviderRef<Rmc>;
String _$secureStorageHash() => r'0cd1b80f91784467390034386f925a0be155bfbd';

/// See also [secureStorage].
@ProviderFor(secureStorage)
final secureStorageProvider = Provider<FlutterSecureStorage>.internal(
  secureStorage,
  name: r'secureStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$secureStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SecureStorageRef = ProviderRef<FlutterSecureStorage>;
String _$packageInfoHash() => r'2a7c0f3591674adadbedbc24a619d23815acdb74';

/// See also [packageInfo].
@ProviderFor(packageInfo)
final packageInfoProvider = Provider<PackageInfo?>.internal(
  packageInfo,
  name: r'packageInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$packageInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PackageInfoRef = ProviderRef<PackageInfo?>;
String _$currentPatchNumberHash() =>
    r'9e5375d76c322730ac2bae263a52919f49104ccd';

/// See also [currentPatchNumber].
@ProviderFor(currentPatchNumber)
final currentPatchNumberProvider = Provider<int?>.internal(
  currentPatchNumber,
  name: r'currentPatchNumberProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentPatchNumberHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentPatchNumberRef = ProviderRef<int?>;
String _$currentLocaleHash() => r'120ca239c7c960b2ff84acd3e60a95f4ea0b5127';

/// See also [CurrentLocale].
@ProviderFor(CurrentLocale)
final currentLocaleProvider = NotifierProvider<CurrentLocale, Locale>.internal(
  CurrentLocale.new,
  name: r'currentLocaleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentLocaleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentLocale = Notifier<Locale>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

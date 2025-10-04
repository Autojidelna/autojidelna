// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentSafeAccount)
const currentSafeAccountProvider = CurrentSafeAccountProvider._();

final class CurrentSafeAccountProvider
    extends $NotifierProvider<CurrentSafeAccount, SafeAccount?> {
  const CurrentSafeAccountProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'currentSafeAccountProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$currentSafeAccountHash();

  @$internal
  @override
  CurrentSafeAccount create() => CurrentSafeAccount();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SafeAccount? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SafeAccount?>(value),
    );
  }
}

String _$currentSafeAccountHash() =>
    r'11c2f6a39da55175615cefeb51e2de2fc7569ba0';

abstract class _$CurrentSafeAccount extends $Notifier<SafeAccount?> {
  SafeAccount? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SafeAccount?, SafeAccount?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<SafeAccount?, SafeAccount?>,
        SafeAccount?,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(currentUser)
const currentUserProvider = CurrentUserProvider._();

final class CurrentUserProvider
    extends $FunctionalProvider<AsyncValue<User?>, User?, FutureOr<User?>>
    with $FutureModifier<User?>, $FutureProvider<User?> {
  const CurrentUserProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'currentUserProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $FutureProviderElement<User?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<User?> create(Ref ref) {
    return currentUser(ref);
  }
}

String _$currentUserHash() => r'90c3003d0c99c902051b7576780a42740a5d2c01';

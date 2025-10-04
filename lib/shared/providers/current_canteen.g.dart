// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_canteen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentCanteen)
const currentCanteenProvider = CurrentCanteenProvider._();

final class CurrentCanteenProvider
    extends $NotifierProvider<CurrentCanteen, Canteen?> {
  const CurrentCanteenProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'currentCanteenProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$currentCanteenHash();

  @$internal
  @override
  CurrentCanteen create() => CurrentCanteen();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Canteen? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Canteen?>(value),
    );
  }
}

String _$currentCanteenHash() => r'477f1fa3291cb42193c94a48f79c3a1f1ef3b593';

abstract class _$CurrentCanteen extends $Notifier<Canteen?> {
  Canteen? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Canteen?, Canteen?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Canteen?, Canteen?>, Canteen?, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

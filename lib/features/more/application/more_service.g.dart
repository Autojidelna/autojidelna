// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'more_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(stavUctu)
const stavUctuProvider = StavUctuProvider._();

final class StavUctuProvider
    extends
        $FunctionalProvider<AsyncValue<StavUctu?>, StavUctu?, Stream<StavUctu?>>
    with $FutureModifier<StavUctu?>, $StreamProvider<StavUctu?> {
  const StavUctuProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stavUctuProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stavUctuHash();

  @$internal
  @override
  $StreamProviderElement<StavUctu?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<StavUctu?> create(Ref ref) {
    return stavUctu(ref);
  }
}

String _$stavUctuHash() => r'9d7cbf9ee8246e83cd96558864335ebb059055fc';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'more_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(stavUctu)
final stavUctuProvider = StavUctuProvider._();

final class StavUctuProvider
    extends
        $FunctionalProvider<AsyncValue<StavUctu?>, StavUctu?, Stream<StavUctu?>>
    with $FutureModifier<StavUctu?>, $StreamProvider<StavUctu?> {
  StavUctuProvider._()
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

String _$stavUctuHash() => r'9e37f6807e9366291535c97a20570d6f0c16114d';

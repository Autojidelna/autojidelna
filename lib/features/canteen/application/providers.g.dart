// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DenniNabidka)
final denniNabidkaProvider = DenniNabidkaFamily._();

final class DenniNabidkaProvider
    extends $AsyncNotifierProvider<DenniNabidka, Jidelnicek> {
  DenniNabidkaProvider._({
    required DenniNabidkaFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'denniNabidkaProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$denniNabidkaHash();

  @override
  String toString() {
    return r'denniNabidkaProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DenniNabidka create() => DenniNabidka();

  @override
  bool operator ==(Object other) {
    return other is DenniNabidkaProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$denniNabidkaHash() => r'027b951a4f98e65b1610b7f629b6716ee75f56d3';

final class DenniNabidkaFamily extends $Family
    with
        $ClassFamilyOverride<
          DenniNabidka,
          AsyncValue<Jidelnicek>,
          Jidelnicek,
          FutureOr<Jidelnicek>,
          DateTime
        > {
  DenniNabidkaFamily._()
    : super(
        retry: null,
        name: r'denniNabidkaProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  DenniNabidkaProvider call(DateTime date) =>
      DenniNabidkaProvider._(argument: date, from: this);

  @override
  String toString() => r'denniNabidkaProvider';
}

abstract class _$DenniNabidka extends $AsyncNotifier<Jidelnicek> {
  late final _$args = ref.$arg as DateTime;
  DateTime get date => _$args;

  FutureOr<Jidelnicek> build(DateTime date);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Jidelnicek>, Jidelnicek>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Jidelnicek>, Jidelnicek>,
              AsyncValue<Jidelnicek>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

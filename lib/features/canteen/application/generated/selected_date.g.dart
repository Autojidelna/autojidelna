// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../selected_date.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedDate)
final selectedDateProvider = SelectedDateProvider._();

final class SelectedDateProvider
    extends $NotifierProvider<SelectedDate, DateTime> {
  SelectedDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedDateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedDateHash();

  @$internal
  @override
  SelectedDate create() => SelectedDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$selectedDateHash() => r'0c30e81f2d6e15a9e825b347227f4249d5ecb51f';

abstract class _$SelectedDate extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

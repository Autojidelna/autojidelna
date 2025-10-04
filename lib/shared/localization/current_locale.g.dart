// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_locale.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentLocale)
const currentLocaleProvider = CurrentLocaleProvider._();

final class CurrentLocaleProvider
    extends $NotifierProvider<CurrentLocale, Locale> {
  const CurrentLocaleProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'currentLocaleProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$currentLocaleHash();

  @$internal
  @override
  CurrentLocale create() => CurrentLocale();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$currentLocaleHash() => r'f33f4467e5b33a49dfe8d1323e407246685f312f';

abstract class _$CurrentLocale extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Locale, Locale>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Locale, Locale>, Locale, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

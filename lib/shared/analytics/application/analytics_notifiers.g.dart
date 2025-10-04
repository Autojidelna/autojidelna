// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AllowAnalytics)
const allowAnalyticsProvider = AllowAnalyticsProvider._();

final class AllowAnalyticsProvider
    extends $NotifierProvider<AllowAnalytics, bool> {
  const AllowAnalyticsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'allowAnalyticsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$allowAnalyticsHash();

  @$internal
  @override
  AllowAnalytics create() => AllowAnalytics();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$allowAnalyticsHash() => r'57e8e381f422e8cb50b32b77c35fcab0007a92a6';

abstract class _$AllowAnalytics extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(SendCrashLogs)
const sendCrashLogsProvider = SendCrashLogsProvider._();

final class SendCrashLogsProvider
    extends $NotifierProvider<SendCrashLogs, bool> {
  const SendCrashLogsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'sendCrashLogsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$sendCrashLogsHash();

  @$internal
  @override
  SendCrashLogs create() => SendCrashLogs();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$sendCrashLogsHash() => r'57e589cc97831213510c69053b89573fd8073feb';

abstract class _$SendCrashLogs extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

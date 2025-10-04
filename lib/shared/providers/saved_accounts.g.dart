// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_accounts.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SavedAccounts)
const savedAccountsProvider = SavedAccountsProvider._();

final class SavedAccountsProvider
    extends $AsyncNotifierProvider<SavedAccounts, Set<SafeAccount>> {
  const SavedAccountsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'savedAccountsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$savedAccountsHash();

  @$internal
  @override
  SavedAccounts create() => SavedAccounts();
}

String _$savedAccountsHash() => r'354d1dcd2ca94aa9423f98996c06329bdf323202';

abstract class _$SavedAccounts extends $AsyncNotifier<Set<SafeAccount>> {
  FutureOr<Set<SafeAccount>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<Set<SafeAccount>>, Set<SafeAccount>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<Set<SafeAccount>>, Set<SafeAccount>>,
        AsyncValue<Set<SafeAccount>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

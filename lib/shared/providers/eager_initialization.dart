import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EagerInitialization extends ConsumerWidget {
  const EagerInitialization({super.key, required this.providers, required this.child});
  final List<ProviderListenable> providers;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Eagerly initialize providers by watching them.
    // By using "watch", the provider will stay alive and not be disposed.
    for (var prov in providers) {
      ref.listen(prov, (_, __) {});
    }
    return child;
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

class _DisableInteractionsNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  @override
  set state(bool newState) => super.state = newState;
  bool update(bool Function(bool state) cb) => state = cb(state);
}

final disableInteractions = NotifierProvider<_DisableInteractionsNotifier, bool>(_DisableInteractionsNotifier.new);

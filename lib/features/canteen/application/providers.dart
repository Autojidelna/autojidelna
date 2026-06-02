import 'package:autojidelna/shared/providers/current_canteen.dart';

import 'package:icanteenlib/canteenlib.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/providers.g.dart';

// TODO: Refactor and merge? together with order method in JidloExtension in [helpers.dart]

// TODO: pridat chache/persistent storage

@Riverpod(keepAlive: true)
class DenniNabidka extends _$DenniNabidka {
  @override
  FutureOr<Jidelnicek> build(DateTime date) async {
    final canteen = ref.read(currentCanteen);
    if (canteen == null) {
      throw StateError('Žádná výdejna není vybrána');
    }
    return await canteen.specifickyJidelnicek(date);
  }

  Future<void> vsechnyJidelnicky() async {
    final canteen = ref.read(currentCanteen);
    if (canteen == null) return;

    try {
      List<Jidelnicek> allMenus = await canteen.vsechnyJidelnicky();
      for (Jidelnicek menu in allMenus) {
        ref.read(denniNabidkaProvider(menu.datum).notifier).state = AsyncData(menu);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> provedObjednavku({required Jidlo jidlo}) async {
    final canteen = ref.read(currentCanteen);
    if (canteen == null) {
      state = const AsyncError('Žádná výdejna není vybrána', StackTrace.empty);
      return;
    }

    try {
      state = AsyncLoading<Jidelnicek>().unwrapPrevious();
      Jidelnicek refreshed = await canteen.provedObjednavku(jidlo);
      state = AsyncData(refreshed);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

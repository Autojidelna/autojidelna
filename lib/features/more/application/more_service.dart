import 'package:autojidelna/core/types/freezed/user/user.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/features/auth/presentation/switch_account_panel.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icanteenlib/canteenlib.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'more_service.g.dart';

class MoreService {
  MoreService(this.user);
  final User? user;

  void openSwitchAccountPannel(BuildContext context) => SwitchAccountPanel.open(context);
}

final moreServiceProvider = Provider<MoreService>((ref) {
  final user = ref.watch(userProvider.select((it) => (it.user)));

  return MoreService(user);
});

@riverpod
Stream<StavUctu?> stavUctu(Ref ref) async* {
  final canteen = ref.watch(currentCanteen)!;
  yield* canteen.stavUctuStream;
}

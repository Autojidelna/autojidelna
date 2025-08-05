import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/shared/settings/providers/settings_notifiers.dart';
import 'package:autojidelna/src/ui/widgets/canteen/list_view/list_view_canteen.dart';
import 'package:autojidelna/src/ui/widgets/canteen/page_view/page_view_canteen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(listUiProvider) ? const ListViewCanteen() : const PageViewCanteen();
  }
}

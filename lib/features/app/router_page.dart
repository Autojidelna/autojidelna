import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:autojidelna/features/canteen/presentation/appbar/menu_appbar.dart';
import 'package:autojidelna/features/more/presentation/more_appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class RouterPage extends ConsumerStatefulWidget {
  const RouterPage({super.key});

  @override
  ConsumerState<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends ConsumerState<RouterPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => showLoginSuccessSnackBar(ref.read(userProvider).user!.accountData.username));
  }

  @override
  Widget build(BuildContext context) {
    List<_Destination> pages = [
      _Destination(
        appbar: const MenuAppBar(),
        route: const MenuRoute(),
        navigationDestination: NavigationDestination(
          icon: const Icon(Icons.menu_book),
          selectedIcon: const Icon(Icons.menu_book_outlined),
          label: context.l10n.menu,
        ),
      ),
      _Destination(
        appbar: const MoreAppBar(),
        route: const MoreRoute(),
        navigationDestination: NavigationDestination(
          icon: const Icon(Icons.more_horiz),
          selectedIcon: const Icon(Icons.more_horiz_outlined),
          label: context.l10n.more,
        ),
      ),
    ];

    return AutoTabsRouter(
      routes: pages.map((p) => p.route).toList(),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final selectedIndex = tabsRouter.activeIndex;

        return Scaffold(
          appBar: pages[selectedIndex].appbar,
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            destinations: pages.map((p) => p.navigationDestination).toList(),
          ),
        );
      },
    );
  }
}

class _Destination {
  _Destination({required this.appbar, required this.route, required this.navigationDestination});
  PreferredSizeWidget appbar;
  PageRouteInfo route;
  NavigationDestination navigationDestination;
}

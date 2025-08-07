import 'package:autojidelna/features/canteen/presentation/appbar/calendar_button.dart';
import 'package:autojidelna/features/canteen/presentation/appbar/jump_to_today_button.dart';
import 'package:flutter/material.dart';

class MenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MenuAppBar({super.key});

  @override
  Widget build(BuildContext context) => AppBar(
        automaticallyImplyLeading: false,
        title: const CalendarButton(),
        actions: const [JumpToTodayButton(), SizedBox(width: 16)],
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/shared/widgets/bouncing_logo.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(body: BouncingLogo());
}

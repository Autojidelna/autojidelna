import 'dart:async';
import 'dart:math';

import 'package:autojidelna/shared/config/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BouncingLogo extends StatefulWidget {
  const BouncingLogo({super.key});

  @override
  State<BouncingLogo> createState() => _BouncingLogoState();
}

class _BouncingLogoState extends State<BouncingLogo> {
  double? posX;
  double? posY;
  double velX = 0;
  double velY = 0;
  late double size;

  late double maxWidth;
  late double maxHeight;

  Timer? timer;
  final Random random = Random();

  double maxSpeed = 1.5;
  double minSpeed = 1.0;

  // Random speed between minSpeed and maxSpeed (inclusive)
  double randomSpeed() => minSpeed + random.nextDouble() * (maxSpeed - minSpeed);

  void startMovement() {
    // Only start if not already started
    if (timer != null && timer!.isActive) return;

    // Initialize velocity with random direction
    velX = (random.nextBool() ? 1 : -1) * randomSpeed();
    velY = (random.nextBool() ? 1 : -1) * randomSpeed();

    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        if (posX == null || posY == null) return;

        posX = posX! + velX;
        posY = posY! + velY;

        if (posX! <= 0 || posX! >= maxWidth) {
          velX = -velX;
        }
        if (posY! <= 0 || posY! >= maxHeight) {
          velY = -velY;
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.sizeOf(context).height * .10;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      maxWidth = constraints.maxWidth - 100; // logo width
      maxHeight = constraints.maxHeight - 50; // logo height

      posX ??= maxWidth / 2;
      posY ??= maxHeight / 2;

      return Stack(
        children: [
          Positioned(
            left: posX!,
            top: posY!,
            child: GestureDetector(
              onTap: startMovement,
              child: SvgPicture.asset(
                Assets.logo,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                height: MediaQuery.sizeOf(context).height * .10,
              ),
            ),
          ),
        ],
      );
    });
  }
}

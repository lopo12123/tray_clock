import 'package:flip_board/flip_clock.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tray_clock/routes/index.dart';
import 'package:tray_clock/styles/palette.dart';

class EntryView extends StatelessWidget {
  const EntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Get.toNamed(MyRoutes.setting),
        onSecondaryTap: () => Get.toNamed(MyRoutes.setting),
        child: Center(
          child: FlipClock(
            flipDirection: AxisDirection.down,
            width: 52,
            height: 72,
            digitSize: 48,
            digitColor: Palette.b90,
            backgroundColor: Palette.b30,
          ),
        ),
      ),
    );
  }
}

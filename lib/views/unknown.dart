import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tray_clock/styles/palette.dart';

class UnknownView extends StatelessWidget {
  const UnknownView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Invalid Page',
          style: TextStyle(
            color: Palette.b30,
            fontSize: 18,
            fontFamily: 'ZhuoKai',
          ),
        ),
        leading: const Icon(Icons.priority_high_rounded, color: Palette.b30),
      ),
      body: Center(
        child: GestureDetector(
          onTap: Get.back,
          child: const Text(
            'Go Back !',
            style: TextStyle(color: Palette.b30, fontSize: 36),
          ),
        ),
      ),
    );
  }
}

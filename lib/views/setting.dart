import 'package:flutter/material.dart';
import 'package:tray_clock/styles/palette.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Setting',
          style: TextStyle(color: Palette.b30, fontSize: 18),
        ),
        leading: const Icon(Icons.settings_rounded, color: Palette.b30),
      ),
    );
  }
}

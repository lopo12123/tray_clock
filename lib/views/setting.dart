import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:tray_clock/styles/palette.dart';
import 'package:tray_clock/utils/notification_impl.dart';
import 'package:window_manager/window_manager.dart';

class _SettingController extends GetxController {
  final isPinned = true.obs;

  Future<void> togglePinned() async {
    if (isPinned.isTrue) {
      await windowManager.setAlwaysOnTop(false);
      isPinned(false);
      NotificationImpl.showAlwaysOnTop(false);
    } else {
      await windowManager.setAlwaysOnTop(true);
      isPinned(true);
      NotificationImpl.showAlwaysOnTop(true);
    }
  }

  @override
  void onInit() async {
    super.onInit();

    isPinned(await windowManager.isAlwaysOnTop());
  }
}

class SettingView extends GetView<_SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(_SettingController());

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Setting',
          style: TextStyle(
            color: Palette.b30,
            fontSize: 18,
            fontFamily: 'ZhuoKai',
          ),
        ),
        leading: const Icon(Icons.settings_rounded, color: Palette.b30),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              tooltip: 'Back',
              highlightColor: Palette.transparent,
              splashColor: Palette.transparent,
              onPressed: Get.back,
              icon: const Icon(Icons.reply, color: Palette.b30),
            ),
            IconButton(
              tooltip: 'Countdown',
              highlightColor: Palette.transparent,
              splashColor: Palette.transparent,
              onPressed: () async {
                NotificationImpl.showCountdownEnd(
                  Duration(seconds: 20).toString(),
                );

                print('rrrr');
              },
              icon: const Icon(Icons.hourglass_top, color: Palette.b30),
            ),
            IconButton(
              tooltip: 'Always on top',
              highlightColor: Palette.transparent,
              splashColor: Palette.transparent,
              onPressed: controller.togglePinned,
              icon: Obx(
                () => Icon(
                  controller.isPinned.isTrue
                      ? Icons.location_on_outlined
                      : Icons.location_off_outlined,
                  color: Palette.b30,
                ),
              ),
            ),
            IconButton(
              tooltip: 'Quit',
              highlightColor: Palette.transparent,
              splashColor: Palette.transparent,
              onPressed: windowManager.close,
              icon: const Icon(Icons.power_settings_new, color: Palette.b30),
            ),
          ],
        ),
      ),
    );
  }
}

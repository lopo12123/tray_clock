import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tray_clock/routes/index.dart';
import 'package:tray_clock/styles/palette.dart';
import 'package:tray_clock/utils/tray_mixin.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';
import 'package:windows_single_instance/windows_single_instance.dart';

/// 配置窗口初始数据
Future<void> setupWindowCfg() async {
  await windowManager.ensureInitialized();

  WindowOptions cfg = const WindowOptions(
    size: Size(400, 150),
    center: true,
    alwaysOnTop: true,
    skipTaskbar: true,
    backgroundColor: Palette.transparent,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(cfg, () async {
    await windowManager.setAsFrameless();
    await windowManager.show();
    await windowManager.focus();
  });
}

/// 确保单实例运行
Future<void> setupSingleTonCfg(List<String> args) async {
  await WindowsSingleInstance.ensureSingleInstance(
    args,
    'tray_clock',
    onSecondWindow: (args) async {
      print('[onSecondWindow] handled.');
      // 唤起并聚焦
      if (await windowManager.isMinimized()) await windowManager.restore();
      windowManager.focus();
    },
  );
}

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupWindowCfg();
  await setupSingleTonCfg(args);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      app: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clock',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            toolbarHeight: 36,
            backgroundColor: Palette.b80,
          ),
          scaffoldBackgroundColor: Palette.b90,
          fontFamily: 'LED',
          tooltipTheme: const TooltipThemeData(
            textStyle: TextStyle(fontFamily: 'ZhuoKai', color: Palette.b30),
          ),
        ),
        initialRoute: MyRoutes.entry,
        unknownRoute: invalidPage,
        getPages: validPages,
        onInit: () async {
          await trayMixin.setup();
          trayManager.addListener(trayMixin);
          print('[GetMaterialApp] onInit');
        },
        onDispose: () {
          trayManager.removeListener(trayMixin);
          print('[GetMaterialApp] onDispose');
        },
      ),
    );
  }
}

class AppFrame extends StatelessWidget {
  final Widget app;

  const AppFrame({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [BoxShadow(color: Palette.b30, blurRadius: 1)],
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (details) => windowManager.startDragging(),
        child: app,
      ),
    );
  }
}

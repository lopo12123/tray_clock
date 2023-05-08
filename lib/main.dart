import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tray_clock/routes/index.dart';
import 'package:tray_clock/styles/palette.dart';
import 'package:window_manager/window_manager.dart';

Future<void> appPrelude() async {
  await windowManager.ensureInitialized();

  WindowOptions cfg = const WindowOptions(
    size: Size(400, 150),
    center: true,
    alwaysOnTop: true,
    backgroundColor: Palette.transparent,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(cfg, () async {
    await windowManager.setAsFrameless();
    await windowManager.show();
    await windowManager.focus();
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await appPrelude();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
          fontFamily: 'ZhuoKai',
        ),
        initialRoute: MyRoutes.entry,
        unknownRoute: invalidPage,
        getPages: validPages,
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

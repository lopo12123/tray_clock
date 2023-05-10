import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class TrayMixin with TrayListener {
  static final instance = TrayMixin();

  Future<void> setup() async {
    await trayManager.setIcon('images/tray_icon.ico');
    await trayManager.setToolTip('Tray Clock');
    await trayManager.setContextMenu(Menu(items: [
      MenuItem(
        label: '退出',
        onClick: (item) {
          windowManager.close();
        },
      ),
    ]));
  }

  @override
  void onTrayIconMouseDown() {
    super.onTrayIconMouseDown();

    trayManager.popUpContextMenu();
  }

  @override
  void onTrayIconRightMouseDown() {
    super.onTrayIconRightMouseDown();

    trayManager.popUpContextMenu();
  }
}

final trayMixin = TrayMixin.instance;

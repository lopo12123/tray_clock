import 'package:local_notifier/local_notifier.dart';

abstract class NotificationImpl {
  static LocalNotification? _singleTon;

  static void _preNotifier() {
    _singleTon?.destroy();
    _singleTon = null;
  }

  static void _postNotified([int sec = 10]) {
    Future.delayed(Duration(seconds: sec), _preNotifier);
  }

  static void showCountdownEnd(String delay) {
    _preNotifier();

    _singleTon = LocalNotification(
      title: 'Countdown Ends',
      body: delay,
    )..show();

    _postNotified();
  }

  static void showAlwaysOnTop(bool enabled) {
    _preNotifier();

    _singleTon = LocalNotification(
      title: 'Always on top',
      body: enabled ? 'on' : 'off',
    )..show();

    _postNotified(5);
  }
}

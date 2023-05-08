import 'package:get/get.dart';
import 'package:tray_clock/views/entry.dart';
import 'package:tray_clock/views/unknown.dart';

/// 路由
abstract class MyRoutes {
  /// 非法路由
  static const invalid = '/invalid';

  /// 入口
  static const entry = '/entry';
}

/// 未知页面
final GetPage invalidPage = GetPage(
  name: MyRoutes.invalid,
  page: () => const UnknownView(),
);

/// 规划页面
final List<GetPage> validPages = [
  GetPage(name: MyRoutes.entry, page: () => const EntryView()),
];

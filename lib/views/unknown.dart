import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnknownView extends StatelessWidget {
  const UnknownView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('未知页面'),
        leading: const Icon(Icons.error_outline),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('返回上一页'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_iframe_message/count_handler.dart';
import 'package:get/get.dart';
import 'home_page.dart';
import 'second_page.dart';
import 'third_page.dart';
import 'webview_page.dart';
import 'offstage_controller.dart';

void main() {
  Get.put(OffstageController()); // 初始化 OffstageController
  Get.put(CountHandler()); // 初始化 OffstageController
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter WebView Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/second', page: () => SecondPage()),
        GetPage(name: '/third', page: () => ThirdPage()),
      ],
      builder: (context, child) {
        final controller = Get.find<OffstageController>();
        print(controller.isOffstage.value);
        return Stack(
          children: [
            Obx(() {
              return Offstage(
                offstage: controller.isOffstage.value,
                child: WebViewPage(),
              );
            }),
            child!,
          ],
        );
      },
    );
  }
}

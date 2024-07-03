import 'package:flutter/material.dart';
import 'package:flutter_iframe_message/count_handler.dart';
import 'package:get/get.dart';
import 'webview_manager.dart';
import 'offstage_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OffstageController offstageController = Get.find();
    final CountHandler countHandler = Get.find();

    return Obx(() => Scaffold(
          backgroundColor:
              !offstageController.isOffstage.value ? Colors.transparent : null,
          appBar: AppBar(
            title: Text('Home Page'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Text(
                      'Count: ${countHandler.count}',
                      style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 47, 255, 210)),
                    )),
                ElevatedButton(
                  onPressed: () {
                    WebViewManager().sendMessageToWeb('Hello from HomePage!');
                  },
                  child: Text("Send Message to WebView"),
                ),
                ElevatedButton(
                  onPressed: () {
                    WebViewManager().sendMessageToWeb('toggle-vconsole');
                  },
                  child: Text("Toggle Vconsole"),
                ),
                ElevatedButton(
                  onPressed: () {
                    print(1);
                    offstageController.toggleWebView();
                  },
                  child: Text("Toggle webview"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/second');
                  },
                  child: Text("Go to Second Page"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/third');
                  },
                  child: Text("Go to Third Page"),
                ),
              ],
            ),
          ),
        ));
  }
}

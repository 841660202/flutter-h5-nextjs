import 'package:flutter/material.dart';
import 'package:flutter_iframe_message/offstage_controller.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'webview_manager.dart';
import 'package:get/get.dart';
import 'count_handler.dart';

class WebViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri('http://localhost:3000')),
      onWebViewCreated: (InAppWebViewController controller) {
        WebViewManager().setController(controller);
        print('WebView created');
      },
      onLoadStop: (controller, url) {
        WebViewManager().addMessageHandler('CountHandler', (args) {
          int newValue = int.tryParse(args[0]) ?? 0;
          Get.find<CountHandler>().updateCount(newValue);
        });
        WebViewManager().addMessageHandler(
          'Toaster',
          (args) {
            debugPrint('JavaScript message: ${args[0]}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(args[0])),
            );
          },
        );
        WebViewManager().addMessageHandler(
          'toggleWebViewHandler',
          (args) {
            Get.find<OffstageController>().toggleWebView();
          },
        );
      },
      onLoadError: (controller, url, code, message) {
        print('Failed to load $url: $message');
      },
    );
  }
}

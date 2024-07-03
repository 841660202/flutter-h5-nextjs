// webview_manager.dart
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewManager {
  static final WebViewManager _instance = WebViewManager._internal();
  InAppWebViewController? _controller;

  factory WebViewManager() {
    return _instance;
  }

  WebViewManager._internal();

  void setController(InAppWebViewController controller) {
    _controller = controller;
  }

  void sendMessageToWeb(String message) {
    if (_controller != null) {
      _controller!.evaluateJavascript(source: "fromFlutter('$message')");
    } else {
      print('Controller is not initialized');
    }
  }

  void addMessageHandler(String handlerName, Function(List<dynamic>) callback) {
    if (_controller != null) {
      _controller!
          .addJavaScriptHandler(handlerName: handlerName, callback: callback);
    } else {
      print('Controller is not initialized');
    }
  }
}

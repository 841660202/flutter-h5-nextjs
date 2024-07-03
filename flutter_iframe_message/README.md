# flutter_iframe_message

A new Flutter project.

```dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hidden WebView Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HiddenWebViewPage(),
    );
  }
}

class HiddenWebViewPage extends StatefulWidget {
  @override
  _HiddenWebViewPageState createState() => _HiddenWebViewPageState();
}

class _HiddenWebViewPageState extends State<HiddenWebViewPage> {
  late WebViewController _controller;
  bool _isWebViewOffstage = true; // WebView 默认隐藏

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hidden WebView Example'),
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: _isWebViewOffstage,
            child: WebView(
              initialUrl: 'https://your-h5-page-url.com', // 替换为你的H5页面URL
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
              },
              javascriptChannels: <JavascriptChannel>{
                _toasterJavascriptChannel(context),
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.evaluateJavascript("fromFlutter('Hello from Flutter!')");
                  },
                  child: Text("Send Message to WebView"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isWebViewOffstage = !_isWebViewOffstage;
                    });
                  },
                  child: Text(_isWebViewOffstage ? "Show WebView" : "Hide WebView"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
}
```

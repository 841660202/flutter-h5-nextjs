import 'package:get/get.dart';

class OffstageController extends GetxController {
  var isOffstage = true.obs;

  void showWebView() {
    isOffstage.value = false;
  }

  void hideWebView() {
    isOffstage.value = true;
  }

  void toggleWebView() {
    isOffstage.value = !isOffstage.value;
  }
}

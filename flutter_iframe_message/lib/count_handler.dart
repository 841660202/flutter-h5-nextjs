import 'package:get/get.dart';

class CountHandler extends GetxController {
  var count = 0.obs;

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }

  void updateCount(int newValue) {
    count.value = newValue;
  }
}

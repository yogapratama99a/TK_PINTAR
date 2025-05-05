import 'package:get/get.dart';

class NotificationController extends GetxController {
  final RxBool _isNotificationActive = false.obs;
  
  bool get isNotificationActive => _isNotificationActive.value;
  
  void toggleNotification() {
    _isNotificationActive.toggle();
    // You can add additional notification logic here
  }
}
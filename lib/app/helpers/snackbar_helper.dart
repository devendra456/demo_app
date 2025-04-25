import 'package:get/get.dart';

class SnackBarHelper {
  static void showSnackBar(String message, [String title = "Message"]) {
    Get.closeAllSnackbars();
    Get.showSnackbar(GetSnackBar(title: title, message: message));
  }
}

import 'package:get/get.dart';
class HomeController extends GetxController {
  final  textSend = "".obs;
  final userIdLogin = "".obs;
  final isSignIn = false.obs;


  void onChangeText(String value) {
    textSend.value = value;
  }
  void onChangeId(String value) {
    userIdLogin.value = value;
  }
  void onChangeSignIn(bool value) {
    isSignIn.value = value;
  }
  void showMessage(String message) {
    Get.snackbar("Show", message);
  }
  void clearTextSend() {
    textSend.value = '';
  }

}
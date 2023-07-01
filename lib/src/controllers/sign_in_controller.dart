import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SignInController extends GetxController{

  var email = "".obs;
  var password = "".obs;

  void onChangeEmail(String value) {
    email.value = value;
  }
  void onChangePassword(String value) {
    password.value = value;
  }
  void showMessage(String message) {
    Get.snackbar("Error", message);
  }
}
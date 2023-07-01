import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  var name = "".obs;
  var email = "".obs;
  var password = "".obs;
  var confirmPassword = "".obs;
  final indexCurrent = 0.obs;

  void onChangeName(String value) {
    name.value = value;
  }

  void onChangeEmail(String value) {
    email.value = value;
  }

  void onChangePassword(String value) {
    password.value = value;
  }

  void onChangeConfirmPassword(String value) {
    confirmPassword.value = value;
  }

  void submitForm() {
    if (validate()) {}
  }

  bool validate() {
    if (name.value.isEmpty) {
      showMessage("nhập name");
      indexCurrent.value = 0;
      return false;
    } else if (email.value.isEmpty) {
      showMessage("nhập email");
      indexCurrent.value = 1;
      return false;
    } else if (!GetUtils.isEmail(email.value)) {
      showMessage("nhập đúng định dạng email");
      indexCurrent.value = 1;
      return false;
    } else if (password.value.isEmpty || confirmPassword.value.isEmpty) {
      showMessage("nhập password");
      indexCurrent.value = 2;
      return false;
    } else if (password.value != confirmPassword.value) {
      showMessage("nhập password == confirmpassword");
      indexCurrent.value = 2;
      return false;
    } else {
      return true;
    }
    // if (name.value.isEmpty ||
    //     email.value.isEmpty ||
    //     password.value.isEmpty ||
    //     confirmPassword.value.isEmpty) {
    //   showMessage("nhập đủ dữ liệu");
    //   return false;
    // } else if (!GetUtils.isEmail(email.value)) {
    //   showMessage("Nhập đúng định dạng email");
    //   return false;
    // } else if (password.value != confirmPassword.value) {
    //   showMessage("password phải giống confirm password");
    //   return false;
    // } else {
    //   return true;
    // }
  }

  void showMessage(String message) {
    Get.snackbar("Error", message);
  }
}

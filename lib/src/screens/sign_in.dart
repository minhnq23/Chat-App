import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:gpt_app/src/controllers/sign_in_controller.dart';
import 'package:gpt_app/src/utilities/shared_preferences_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class SignIn extends StatelessWidget {
  final SignInController controller = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 15, top: 30, bottom: 50),
              child: const Text(
                "Đăng nhập",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.blue),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20, left: 20),
              margin: const EdgeInsets.only(top: 15, bottom: 10),
              child: TextFormField(
                onChanged: controller.onChangeEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20, left: 20),
              margin: const EdgeInsets.only(top: 15, bottom: 10),
              child: TextFormField(
                onChanged: controller.onChangePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20, left: 20),
              margin: const EdgeInsets.only(top: 15, bottom: 5),
              child: AnimatedButton(
                text: 'Đăng nhập',
                textStyle: const TextStyle(color: Colors.blue),
                selectedTextColor: Colors.blue,
                borderRadius: 5,
                borderColor: Colors.blue,
                borderWidth: 1,
                onPress: () {
                  signIn();
                },
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {Get.toNamed("/signup");},
              child: const Text('đăng ký'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    List<User> users = [];
    users = await getUsers();
    for (var user in users) {
      if (user.email == controller.email.value &&
          user.password == controller.password.value) {

        await SharedPreferencesApp.setId(user.id);

        Get.toNamed("/home");
      }
    }
  }


  Future<List<User>> getUsers() async {
    List<User> userList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    querySnapshot.docs.forEach((doc) {
      // Lấy dữ liệu từ mỗi document và tạo đối tượng User
      User user = User.fromDocumentSnapshot(doc);
      userList.add(user);
    });

    return userList;
  }
}

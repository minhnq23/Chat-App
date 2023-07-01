import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpt_app/src/controllers/sign_up_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gpt_app/src/model/user.dart';

class SignUp extends StatelessWidget {
  Future<void> addUser() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    signUpController.showMessage("Đang tạo tài khoản...");
    Map<String, dynamic> userData = {
      'name': signUpController.name.value,
      'email': signUpController.email.value,
      'password': signUpController.password.value,
      'image': '',
    };
    fireStore.collection('users').doc().set(userData)
        .then((value) {
      signUpController.showMessage('Thêm người dùng thành công');
    })
        .catchError((error) {
      signUpController.showMessage('Thêm người dùng thất bại: $error');
    });

  }

  final SignUpController signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0x00FFFFFF),
          elevation: 0,
          title: const Text(""),
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: [
              // banner
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  padding: const EdgeInsets.only(left: 20),
                  child: const Text(
                    "Đăng ký tài khoản",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blue),
                  )),
              Obx(() => Stepper(
                      currentStep: signUpController.indexCurrent.value,
                      onStepTapped: (int index) {
                        signUpController.indexCurrent.value = index;
                      },
                      onStepCancel: () {
                        if (signUpController.indexCurrent.value > 0) {
                          signUpController.indexCurrent.value -= 1;
                        }
                      },
                      onStepContinue: () {
                        if (signUpController.indexCurrent.value < 3) {
                          signUpController.indexCurrent.value += 1;
                        } else if (signUpController.indexCurrent.value >= 3) {
                          // User user = User("", "", "");
                          // user.name = signUpController.name.value;
                          // user.email = signUpController.email.value;
                          // user.password = signUpController.password.value;

                          if (signUpController.validate() == true) {
                            addUser();
                          }
                        }
                      },
                      controlsBuilder:
                          (BuildContext context, ControlsDetails details) {
                        return Row(
                          children: <Widget>[
                            TextButton(
                              onPressed: details.onStepCancel,
                              child: const Text('cancel'),
                            ),
                            ElevatedButton(
                              onPressed: details.onStepContinue,
                              child: const Text('next'),
                            ),
                          ],
                        );
                      },
                      steps: [
                        Step(
                          title: const Text("Input Name"),
                          isActive: signUpController.indexCurrent.value == 0,
                          content: Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 20, right: 20, bottom: 10),
                            child: TextFormField(
                              onChanged: signUpController.onChangeName,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                              ),
                            ),
                          ),
                        ),
                        Step(
                          title: const Text("Input email"),
                          isActive: signUpController.indexCurrent.value == 1,
                          content: Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 20, right: 20, bottom: 10),
                            child: TextFormField(
                              onChanged: signUpController.onChangeEmail,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                            ),
                          ),
                        ),
                        Step(
                          title: const Text("Input password"),
                          isActive: signUpController.indexCurrent.value == 2,
                          content: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 10, left: 20, right: 20, bottom: 10),
                                child: TextFormField(
                                  onChanged: signUpController.onChangePassword,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 10, left: 20, right: 20, bottom: 10),
                                child: TextFormField(
                                  onChanged:
                                      signUpController.onChangeConfirmPassword,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Confirm Password',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Step(
                          title: const Text("Thông tin"),
                          isActive: signUpController.indexCurrent.value == 3,
                          content: Container(
                            margin: const EdgeInsets.only(bottom: 15, top: 10),
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 5, top: 5),
                                  child: Row(
                                    children: [
                                      const Text("Name:  "),
                                      Text(signUpController.name.value)
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 5, top: 5),
                                  child: Row(
                                    children: [
                                      const Text("Email:  "),
                                      Text(signUpController.email.value)
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 5, top: 5),
                                  child: Row(
                                    children: [
                                      const Text("Password:  "),
                                      Text(signUpController.password.value)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ])),
            ],
          ),
        )));
  }
}

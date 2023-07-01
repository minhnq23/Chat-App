import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gpt_app/src/controllers/home_controller.dart';
import 'package:gpt_app/src/model/user.dart';
import 'package:gpt_app/src/open_ai/constant.dart';
import 'package:gpt_app/src/screens/chat_screen.dart';
import 'package:gpt_app/src/screens/user_item.dart';
import 'package:gpt_app/src/utilities/shared_preferences_app.dart';

import 'chat_widget.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  bool _isTyping = false;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');


  @override
  Widget build(BuildContext context) {
    getUserId();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              controller.showMessage(controller.userIdLogin.value);
            },
          ),
          title: Obx(() => Text(controller.userIdLogin.value)),
        ),
        body: Column(
          children: [
            Flexible(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GetBuilder<HomeController>(
                      builder: (_) => FutureBuilder<List<User>>(
                        future: getList(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<User> users = snapshot.data != null
                                ? List<User>.from(snapshot.data as Iterable)
                                : [];

                            return ListView.builder(
                              itemExtent: 60,
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () => {
                                          Get.toNamed('/chatscreen',
                                              arguments: users[index].id),
                                        },
                                    child: UserWidget(
                                      sender: users[index].name,
                                      id: users[index].id,
                                    ));
                              },
                            );
                            // Widget hiển thị giao diện của trang
                          }
                        },
                      ),
                    ))),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.blue,
                size: 18,
              )
            ],
            Container(
              height: 60,
              padding: const EdgeInsets.only(bottom: 5, top: 5, left: 5),
              color: Colors.white70,
              // child: _buidTextSend(context),
            )
          ],
        ),
      ),
    );
  }

  void getUserId() async {
    controller.showMessage("Dữ liệu đã được lưu trong Shared Preferences");
    String id = await SharedPreferencesApp.getId("id");
    if (id != null && id.isNotEmpty) {
      controller.showMessage("Dữ liệu đã được lưu trong Shared Preferences: $id");
    } else {
      controller.showMessage("Dữ liệu chưa được lưu trong Shared Preferences");
    }
    controller.userIdLogin.value = id;
  }
  Future<List<User>> getList() async {

    List<User> users = [];
    users = await getUsers();
    return users;
  }

  Future<List<User>> getUsers() async {
    List<User> userList = [];
    String id = await SharedPreferencesApp.getId("id");

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    querySnapshot.docs.forEach((doc) {
      // Lấy dữ liệu từ mỗi document và tạo đối tượng User
      User user = User.fromDocumentSnapshot(doc);
      userList.add(user);
      userList.retainWhere((user) => user.id != id);
    });


    return userList;
  }

  Future<User> getUserById(String id) async {
    final userDoc = await usersCollection.doc(id).get();

    return User.fromDocumentSnapshot(userDoc);
  }

  // void _send() {
  //   ChatWidget _chatWidget =
  //       ChatWidget(text: controller.textSend.value, sender: "Minh");
  //   _listMes.add(_chatWidget);
  // }

  // Widget _buidTextSend(BuildContext context) {
  //   final TextEditingController textController = TextEditingController();
  //   return Row(
  //     children: [
  //       Expanded(
  //           child: TextField(
  //         controller: textController,
  //         onChanged: controller.onChangeText,
  //         decoration: const InputDecoration.collapsed(
  //           hintText: "send a message",
  //         ),
  //       )),
  //       IconButton(
  //           onPressed: () {
  //             FocusScope.of(context).unfocus();
  //             _send();
  //
  //
  //           },
  //           icon: const Icon(
  //             Icons.send,
  //             color: Colors.blue,
  //           ))
  //     ],
  //   );
  // }
}

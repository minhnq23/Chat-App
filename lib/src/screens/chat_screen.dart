import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpt_app/src/controllers/chat_controller.dart';
import 'package:get/get.dart';
import 'package:gpt_app/src/model/messager.dart';
import 'package:gpt_app/src/widgets/list_widget.dart';

import '../utilities/shared_preferences_app.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final String accepterId = Get.arguments;
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Obx(() => Text("${controller.accepter_name.value}")),
      ),
      body: Container(
          child: Column(
        children: [
          Flexible(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: MessagerList(messages: controller.messages),
            ),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.only(bottom: 5, top: 5, left: 5),
            color: Colors.white70,
            child: _buidTextSend(context),
          )
        ],
      )),
    ));
  }

  Widget _buidTextSend(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: textController,
          onChanged: controller.onChangeText,
          decoration: const InputDecoration.collapsed(
            hintText: "send a message",
          ),
        )),
        IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              // chek chat tồn tại
              controller
                  .fetchChatByMembers([accepterId, controller.senderId.value]);
              // add message
              controller.addMessage();
            },
            icon: const Icon(
              Icons.send,
              color: Colors.blue,
            ))
      ],
    );
  }
}

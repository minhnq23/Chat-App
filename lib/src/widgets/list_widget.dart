


import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:gpt_app/src/controllers/chat_controller.dart';
import 'package:gpt_app/src/screens/message_item.dart';
import 'package:get/get.dart';

import '../model/messager.dart';

class MessagerList extends StatelessWidget {
  MessagerList({super.key, required this.messages});
  final   RxList<Messager> messages;
  final ChatController controller = Get.put(ChatController());




 

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller.scrollController.jumpTo(controller.scrollController.position.maxScrollExtent);
    });


    return Obx(() {
      return ListView.builder(
        itemCount: messages.length,
        controller: controller.scrollController,
        reverse: true,
        itemBuilder: (BuildContext context, int index) {
          List<Messager> sortedMessages = messages.toList()
            ..sort((a, b) => b.timeSend.compareTo(a.timeSend));

          Messager messager = sortedMessages[index];




          return FutureBuilder<String>(
            future: controller.SenderName(messager.senderId),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(); // Hiển thị tiến trình đang chờ Future hoàn thành
              } else if (snapshot.hasError) {
                return Text('Lỗi: ${snapshot.error}'); // Xử lý lỗi nếu có
              } else {
                String senderName = snapshot.data ?? '';
                return MessageWidget(senderName: senderName, content: messager.content,senderId: messager.senderId,);
              }
            },
          );
        },
      );

    });

  }
}

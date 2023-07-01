import 'package:flutter/material.dart';

import '../controllers/chat_controller.dart';
import 'package:get/get.dart';

class MessageWidget extends StatelessWidget {
  MessageWidget({super.key, required this.senderName, required this.content, required this.senderId});
  final String senderName;
  final String content;
  final String senderId;
  final ChatController controller = Get.put(ChatController());


  @override
  Widget build(BuildContext context) {
    bool isMe = senderId == controller.senderId.value;
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 5),
      padding: const EdgeInsets.only(top: 2,bottom:2),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              senderName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue,
              // color: isMe ? Colors.blue : Colors.grey[200],
              borderRadius: BorderRadius.circular(20),

            ),
            child:  Padding(
              padding:  const EdgeInsets.all(4.0),
              child: Text(
                content,
                style:const  TextStyle(
                  color: Colors.white
                  // color: isMe ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

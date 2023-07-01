import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.text, required this.sender});
  final String text;
  final String sender;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5,top: 2,bottom: 2),
      child: Row(

        children: [
          Container(
            margin:const EdgeInsets.only(right: 15,top: 5,bottom:5),
            child: CircleAvatar(child: Text(sender[0])),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(sender, style: const TextStyle(
              fontWeight: FontWeight.bold,

            ),),
              Container(
                margin: const EdgeInsets.only(top: 7),
                child: Text('$text'),
              )


          ],))
        ],
      ),
    );
  }
}

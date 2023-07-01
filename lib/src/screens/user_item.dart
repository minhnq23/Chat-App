import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  final String sender;
  final String id;
  const UserWidget({super.key, required this.sender, required this.id});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15, top: 0, bottom: 0),
            child: CircleAvatar(child: Text(sender[0])),
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(top: 5),
            child: (Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text("$id"),
                ),

              ],
            )),
          ))
        ],
      ),
    );
  }
}

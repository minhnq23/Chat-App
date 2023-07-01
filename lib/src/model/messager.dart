import 'package:cloud_firestore/cloud_firestore.dart';

class Messager {
  String _id;
  String _content;
  String _chatId;
  String _senderId;
  Timestamp _timeSend;


  Messager(
      this._id, this._content, this._chatId, this._senderId, this._timeSend);

  String get senderId => _senderId;

  set senderId(String value) {
    _senderId = value;
  }

  String get chatId => _chatId;

  set chatId(String value) {
    _chatId = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  Timestamp get timeSend => _timeSend;

  set timeSend(Timestamp value) {
    _timeSend = value;
  }

  factory Messager.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Messager(doc.id,data['content'] ?? '', data['chatId'] ?? '',
        data['senderId'] ?? '', data['timeSend']??'' );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_app/src/utilities/shared_preferences_app.dart';

import '../model/messager.dart';
import '../model/user.dart';

class ChatController extends GetxController {
  ScrollController scrollController = ScrollController();
  final content = "".obs;
  final senderId = "".obs;
  final chatId = "".obs;
  final senderName = "".obs;
  final accepter_name = "".obs;
  final messages = <Messager>[].obs;

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    final String accepterId = Get.arguments;
    String id = await SharedPreferencesApp.getId("id");
    senderId.value = id;
    getUserId();
    accepterName(accepterId);
    print("sender id:${id} ");
    print("accepter id:${accepterId}");

    fetchChatByMembers([accepterId, id]);
  }

  void onChangeText(String value) {
    content.value = value;
  }

  void clearTextSend() {
    content.value = '';
  }

  // void onChangeId(String value) {
  //   senderId.value = value;
  // }
  // void onChangeChatId(String value) {
  //   chatId.value = value;
  // }
  void showMessage(String message) {
    Get.snackbar("Show", message);
  }

  void addChat(List<String> ids) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    // add đoạn chat
    Map<String, dynamic> chatData = {
      'members': ids,
    };
    fireStore.collection('chats').doc().set(chatData).then((value) {
      print('Đoạn chat đã được đăng thành công');
      DocumentReference docRef = value as DocumentReference;
      chatId.value = docRef.id;
    }).catchError((error) {
      print('Lỗi khi đăng đoạn chat: $error');
    });
  }

  void fetchChatByMembers(List<String> memberIds) {
    showMessage('$memberIds');
    // check xem đoạn chat tồn tại giữa 2 user không

    FirebaseFirestore.instance
        .collection('chats')
        .where('members', arrayContainsAny: memberIds)
        .get()
        .then((QuerySnapshot querySnapshot) {
      // chuyển dạng dữ liệu thành map
      List<DocumentSnapshot> matchingChats = querySnapshot.docs.where((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        List<dynamic>? chatMembers = data?['members'] as List<dynamic>?;
        return memberIds
            .every((memberId) => chatMembers?.contains(memberId) ?? false);
      }).toList();

      if (matchingChats.isEmpty) {
        // Không tìm thấy đoạn chat
        showMessage('Không tìm thấy đoạn chat');
        addChat(memberIds);
        fetchMessages();
      } else {
        // Có tồn tại đoạn chat
        matchingChats.forEach((doc) {
          print("Chat đã tồn tại: ${doc.data()}");
          // Đoạn chat được lấy từ Firestore
          print(doc.data());
          print('${doc.id} id chat');
          chatId.value = doc.id;
          fetchMessages();
        });
      }
    });
  }

  void getUserId() async {
    showMessage("Dữ liệu đã được lưu trong Shared Preferences");
    String id = await SharedPreferencesApp.getId("id");
    if (id != null && id.isNotEmpty) {
      showMessage("Dữ liệu đã được lưu trong Shared Preferences: $id");
    } else {
      showMessage("Dữ liệu chưa được lưu trong Shared Preferences");
    }
    senderId.value = id;
  }

  void fetchMessages() async {
    try {
      List<Messager> fetchedMessages =
          await getMessages(); // Gọi hàm lấy tin nhắn từ Firestore
      messages.assignAll(fetchedMessages);
      print("${messages}");
    } catch (error) {
      print('Error fetching messages: $error');
    }
  }

  Future<List<Messager>> getMessages() async {
    print(chatId.value + " hehe");
    List<Messager> mesList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('messages').get();

    querySnapshot.docs.forEach((doc) {
      // Lấy dữ liệu từ mỗi document và tạo đối tượng mes
      Messager messager = Messager.fromDocumentSnapshot(doc);
      mesList.add(messager);
      mesList.retainWhere((mes) => mes.chatId == chatId.value);
    });

    print("messlist : ${mesList.length}");
    return mesList;
  }

  void addMessage() {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    Timestamp now = Timestamp.now();
    print("meme$now");
    // add đoạn chat
    Map<String, dynamic> chatData = {
      'senderId': senderId.value,
      'chatId': chatId.value,
      'content': content.value,
      'timeSend': now,

    };
    fireStore.collection('messages').doc().set(chatData).then((value) {
      print('mes đã được đăng thành công');
    }).catchError((error) {
      print('Lỗi khi đăng mes chat: $error');
    });
  }

  void accepterName(String id) async {
    User user = await getUserById(id);
    accepter_name.value = user.name;
    print("accepter_name ${accepter_name.value}");
  }
  Future<String> SenderName(String id) async {
    User user = await getUserById(id);
    senderName.value = user.name;
    print("senderName ${senderName.value}");
    return user.name;
  }
  Future<User> getUserById(String id) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    final userDoc = await usersCollection.doc(id).get();
    return User.fromDocumentSnapshot(userDoc);
  }
}

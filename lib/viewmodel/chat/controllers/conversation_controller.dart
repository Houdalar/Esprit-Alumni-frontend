import 'dart:developer';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:esprit_alumni_frontend/model/serchUser.dart';
import 'package:esprit_alumni_frontend/viewmodel/chat/services/conversation_service.dart';
import 'package:esprit_alumni_frontend/viewmodel/chat/services/messages_service.dart';
import 'package:esprit_alumni_frontend/viewmodel/chat/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../model/message.dart';

class ConversationController extends GetxController {
  final TextEditingController textEditingcontroller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();
  final RxList<SearchUser> searchResults = <SearchUser>[].obs;
  final RxBool isSearchActive = false.obs;

  bool emojiShowed = false;
  late io.Socket socket;
  RxBool sendButton = false.obs;
  var messagesList = <MessageModel>[].obs;

  @override
  void onInit() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        emojiShowed = false;
        update();
      }
    });

    searchController.addListener(() {
      onSearchTextChanged(searchController.text);
    });
    super.onInit();
  }

  /// connect the app to the socket.io server
  /// so every app will be treated as a socket.io client
  void connect(String sourchatId, String targetId) {
    socket = io.io("http://10.0.2.2:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    //connecter le socket server manuellement
    socket.connect();
    socket.onDisconnect((_) => print('disconnect'));
    socket.onError((data) => print('error: $data'));

    socket.emit("signin", sourchatId);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        //add the msg to the messages' list and specify its type as a destination msg
        NotificationService().sendNotification(msg["targetId"]);
        setMessage(
            msg["sourceId"], msg["targetId"], msg["message"], msg["createdAt"]);
        update();
        //scroll to the bottom of the listview
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
      });
    });
    print(socket.connected);
  }

  void sendMessage(
      String message, String sourceId, String targetId, String date) {
    //add the msg to the messages' list and specify its type as a source msg
    setMessage(sourceId, targetId, message, date);
    //send a json objetct from the source to the target
    //"message" is the event name and with its help we'll listen to it on the socket server
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
    });

    textEditingcontroller.clear();
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
    update();
  }

  //whenever we'll send a msg or receive a message we'll add it to the messages' list
  void setMessage(String sourceId, String targetId, String msg, String date) {
    MessageModel messageModel = MessageModel(
      sourceId: sourceId,
      targetId: targetId,
      message: msg,
      createdAt: date,
    );

    messagesList.add(messageModel);
    messagesList.refresh();

    update();
  }

  Future<String> getMessage(String messageId) async {
    final message = await MessagesService.getMessage(messageId);
    return message;
  }

  void toggleEmojiPicker(BuildContext context) {
    emojiShowed = !emojiShowed;
    FocusScope.of(context).unfocus();

    update();
  }

  void onEmojiSelected(Emoji emoji) {
    textEditingcontroller.text += emoji.emoji;
    update();
  }

  String formatDateTime(String date) {
    log(date);
    DateTime dateTime = DateTime.parse(date);
    return "${dateTime.hour}:${dateTime.minute}";
  }

  getConversationMessages(String sourceId, String targetId) async {
    ConversationService.getConversationMessages(sourceId, targetId)
        .then((value) {
      messagesList = <MessageModel>[].obs;
      messagesList.addAll(value);
      log(messagesList.toString());
      messagesList.refresh();
      Future.delayed(const Duration(milliseconds: 300), () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 600), curve: Curves.ease);
      });
      update();
    });
    messagesList.refresh();

    update();
  }

  deleteMessage(String messageId) async {
    ConversationService.deleteMessage(messageId).then((value) {
      messagesList.removeWhere((element) => element.id == messageId);
      messagesList.refresh();
      update();
    });
    messagesList.refresh();
    update();
  }

  deleteConversation(String sourceId, String targetId) async {
    ConversationService.deleteConversation(sourceId, targetId).then((value) {
      messagesList.refresh();
      update();
    });
    messagesList.refresh();
    update();
  }

  void clearSearchResults() {
    searchResults.clear();
    isSearchActive.value = false;
    searchResults.refresh();
    update();
  }

  void onSearchTextChanged(String query) async {
    if (query.isNotEmpty) {
      final users = await ConversationService.searchUsers(query);
      searchResults.assignAll(users);
      isSearchActive.value = true;
    } else {
      clearSearchResults();
    }
  }

  @override
  void onClose() {
    textEditingcontroller.dispose();
    scrollController.dispose();
    focusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  void toggleSendButton(String value) {
    if (value.isNotEmpty) {
      sendButton.value = true;
    } else {
      sendButton.value = false;
    }
    update();
  }
}

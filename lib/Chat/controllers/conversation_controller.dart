import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:esprit_alumni_frontend/Chat/Models/message.dart';
import 'package:esprit_alumni_frontend/Chat/Models/message_model.dart';
import 'package:esprit_alumni_frontend/Chat/services/conversation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

class ConversationController extends GetxController {
  final TextEditingController textEditingcontroller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  bool emojiShowed = false;
  late io.Socket socket;
  RxBool sendButton = false.obs;
  RxList<MessageModel> messages = <MessageModel>[].obs;
  RxList<Message> messagesList = <Message>[].obs;

  @override
  void onInit() {
    // connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        emojiShowed = false;
        update();
      }
    });

    super.onInit();
  }

  /// connect the app to the socket.io server
  /// so every app will be treated as a socket.io client
  void connect(int sourchatId) {
    socket = io.io("http://192.168.1.149:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    //connecter le socket server manuellement
    socket.connect();
    socket.emit("signin", sourchatId);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        //add the msg to the messages' list and specify its type as a destination msg
        setMessage("destination", msg["message"]);
        //scroll to the bottom of the listview
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
      });
    });
    print(socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    //add the msg to the messages' list and specify its type as a source msg
    setMessage("source", message);
    //send a json objetct from the source to the target
    //"message" is the event name and with its help we'll listen to it on the socket server
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  //whenever we'll send a msg or receive a message we'll add it to the messages' list
  void setMessage(String type, String msg) {
    MessageModel messsageModel = MessageModel(
        type: type,
        message: msg,
        time: DateTime.now().toString().substring(10, 16));

    messages.add(messsageModel);
    messages.refresh();
    update();
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
    DateTime dateTime = DateTime.parse(date);
    return "${dateTime.hour}:${dateTime.minute}";
  }

  getConversationMessages(int sourceId, int targetId) async {
    ConversationService.getConversationMessages(sourceId, targetId)
        .then((value) => messagesList.addAll(value));
    update();
  }

  @override
  void onClose() {
    textEditingcontroller.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}

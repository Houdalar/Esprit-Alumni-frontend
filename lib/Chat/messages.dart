import 'package:esprit_alumni_frontend/Chat/Models/chat_model.dart';
import 'package:esprit_alumni_frontend/Chat/widgets/message_card.dart';
import 'package:flutter/material.dart';

import 'design/app_colors.dart';
import 'widgets/search_bar.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key, required this.chatmodels, required this.sourcChat})
      : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourcChat;

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 60.0),
          child: Center(
            child: Text(
              "Messages",
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SearchBar(),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.chatmodels.length,
            itemBuilder: (context, index) => MessageCard(
              chatModel: widget.chatmodels[index],
              sourchat: widget.sourcChat,
            ),
          ),
        ),
      ],
    ));
  }
}

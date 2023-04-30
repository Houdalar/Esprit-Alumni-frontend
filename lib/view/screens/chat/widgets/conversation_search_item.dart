import 'package:esprit_alumni_frontend/model/chat_model.dart';
import 'package:esprit_alumni_frontend/view/screens/chat/conversation.dart';
import 'package:flutter/material.dart';

class ConversationSearchItem extends StatelessWidget {
  final String username;
  final String profileImage;
  final ChatModel? chatModel;
  final String? sourchat;

  const ConversationSearchItem(
      {super.key,
      required this.username,
      required this.profileImage,
      this.chatModel,
      required this.sourchat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Conversation(chatModel: chatModel, sourchat: sourchat)));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(profileImage),
        ),
        title: Text(username),
      ),
    );
  }
}

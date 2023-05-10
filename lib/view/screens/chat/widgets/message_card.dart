import 'package:esprit_alumni_frontend/model/chat_model.dart';
import 'package:esprit_alumni_frontend/view/screens/chat/conversation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MessageCard extends StatelessWidget {
  const MessageCard(
      {Key? key,
      required this.chatModel,
      required this.sourchat,
      // required this.otherUser,
      this.targetId})
      : super(key: key);
  final ChatModel chatModel;
  final String? sourchat;
  final String? targetId;
  //final UserInfoModel otherUser;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(
                    chatModel: chatModel, sourchat: sourchat)));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ListTile(
              leading: chatModel.image != null
                  //leading: otherUser.profileImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        chatModel.image ?? "",
                        //otherUser.profileImage ?? "",
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SvgPicture.asset("assets/images/person_icon.svg"),
              title: Text(
                chatModel.name ?? "",
                // otherUser.username ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.done_all,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      chatModel.currentMessage!.length > 21
                          ? "${chatModel.currentMessage!.substring(0, 21)}..."
                          : chatModel.currentMessage ?? "",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              // trailing: Padding(
              //   padding: const EdgeInsets.only(right: 20.0),
              //   child: Text(chatModel.time ?? "20:47"),
              // ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: 30, left: MediaQuery.of(context).size.width * 0.08),
            child: const Divider(
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}

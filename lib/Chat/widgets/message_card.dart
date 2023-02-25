import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Models/chat_model.dart';
import '../conversation.dart';
import '../design/app_colors.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({Key? key, required this.chatModel, required this.sourchat})
      : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Conversation(
                      chatModel: chatModel,
                      sourchat: sourchat,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
                radius: 43,
                backgroundColor: AppColors.svgBackgroundClr,
                child: SvgPicture.asset(
                  chatModel.isGroup
                      ? "assets/images/groups_icon.svg"
                      : "assets/images/person_icon.svg",
                  color: AppColors.primaryColorDark,
                  height: 40,
                  width: 40,
                )),
            title: Text(
              chatModel.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                const Icon(
                  Icons.done_all,
                  size: 16,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  chatModel.currentMessage,
                  style: const TextStyle(fontSize: 15),
                )
              ],
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(chatModel.time),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: 30, left: MediaQuery.of(context).size.width * 0.25),
            child: const Divider(
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}

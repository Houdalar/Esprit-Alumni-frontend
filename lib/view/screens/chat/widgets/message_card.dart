import 'package:esprit_alumni_frontend/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../conversation.dart';

class MessageCard extends StatelessWidget {
  const MessageCard(
      {Key? key,
      required this.chatModel,
      required this.sourchat,
      this.targetId})
      : super(key: key);
  final ChatModel chatModel;
  final String? sourchat;
  final String? targetId;

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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ListTile(
              leading: chatModel.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        chatModel.image ?? "",
                        //color: AppColors.primaryColorDark,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SvgPicture.asset("assets/images/person_icon.svg"),
              title: Text(
                chatModel.name ?? "",
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
                    chatModel.currentMessage ?? "",
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(chatModel.time ?? "20:47"),
              ),
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

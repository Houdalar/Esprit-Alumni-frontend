import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Models/chat_model.dart';
import '../conversation.dart';
import '../design/app_colors.dart';

class MessageCard extends StatelessWidget {
  MessageCard({Key? key, required this.chatModel}) : super(key: key);
  ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Conversation(
                      chatModel: ChatModel(
                          name: "Ines Said",
                          currentMessage: "I'm all ears",
                          time: '23:10',
                          icon: 'assets/images/ines.jpg',
                          isGroup: true))));
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
              title: const Text(
                "Ines Said",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Row(
                children: const [
                  Icon(
                    Icons.done_all,
                    size: 16,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "I'm all ears",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              trailing: const Text("21:38"),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 80),
              child: Divider(
                thickness: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

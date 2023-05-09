import 'package:esprit_alumni_frontend/model/chat_model.dart';
import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:esprit_alumni_frontend/view/screens/chat/conversation_screen.dart';
import 'package:esprit_alumni_frontend/viewmodel/chat/controllers/messages_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ConversationSearchItem extends StatelessWidget {
  final String username;
  final String profileImage;
  final String? targetUserId;
  final String? sourchat;

  const ConversationSearchItem(
      {super.key,
      required this.username,
      required this.profileImage,
      this.targetUserId,
      required this.sourchat});

  @override
  Widget build(BuildContext context) {
    final messsageController = Get.put(MessageController());

    return InkWell(
      onTap: () {
        ChatModel? chatModel = messsageController.chatModels.firstWhere(
            (chat) => chat?.targetId == targetUserId,
            orElse: () => null);

        chatModel ??= ChatModel(
          name: username,
          image: profileImage,
          currentMessage: '',
          time: '',
          targetId: targetUserId,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationScreen(
              chatModel: chatModel,
              sourchat: sourchat,
              profileImage: profileImage,
            ),
          ),
        );
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(profileImage),
        ),
        title: Text(
          username,
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          )),
        ),
        subtitle: Row(
          children: [
            Text(
              "Say Hi to ",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                fontSize: 13,
                color: AppColors.primaryColorDark,
                fontWeight: FontWeight.w400,
              )),
            ),
            Text(
              "$username !",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                fontSize: 13,
                color: AppColors.primaryColorDark,
                fontWeight: FontWeight.w400,
              )),
            ),
            const SizedBox(
              width: 20,
            ),
            SvgPicture.asset(
              "assets/images/emoji _waving_hand sign.svg",
              width: 21,
              height: 21,
            )
          ],
        ),
      ),
    );
  }
}

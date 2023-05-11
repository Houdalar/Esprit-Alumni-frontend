import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:esprit_alumni_frontend/view/screens/chat/search_conversation.dart';
import 'package:esprit_alumni_frontend/view/screens/chat/widgets/message_card.dart';
import 'package:esprit_alumni_frontend/viewmodel/chat/controllers/messages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
        init: MessageController(),
        initState: (_) {},
        builder: (controller) {
          return Stack(children: [
            GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Scaffold(
                  body: Stack(children: [
                    Container(
                      decoration: const BoxDecoration(
                          gradient: AppColors.gradientBackground),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.08),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 50.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 22,
                                    color: AppColors.white,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "Conversations",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400)),
                                ),
                                const Spacer()
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Expanded(
                            child: Stack(children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40))),
                              ),
                              controller.conversationsList.isNotEmpty
                                  ? ListView.builder(
                                      itemCount:
                                          controller.conversationsList.length,
                                      itemBuilder: (context, index) =>
                                          MessageCard(
                                        chatModel:
                                            controller.chatModels[index]!,
                                        sourchat: controller.userId,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        "No Conversations yet !",
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                      ),
                                    ),
                            ]),
                          )
                        ],
                      ),
                    )
                  ]),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchConversation()),
                      );
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.gradientColor),
                      child: const Icon(Icons.message),
                    ),
                  ),
                ))
          ]);
        });
  }
}

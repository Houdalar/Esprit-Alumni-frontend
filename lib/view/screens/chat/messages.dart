import 'package:esprit_alumni_frontend/view/screens/chat/widgets/message_card.dart';
import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:esprit_alumni_frontend/viewmodel/chat/controllers/messages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_conversation.dart';

class Messages extends GetView<MessageController> {
  Messages({Key? key}) : super(key: key);
  //final List<ChatModel> chatmodels;
  //final ChatModel sourcChat;

  // @override
  // State<Messages> createState() => _MessagesState();

// class _MessagesState extends State<Messages> {
//   TextEditingController textController = TextEditingController();
//   late final List<ChatModel> _chatmodels = [];

  String? userId;

  @override
  Widget build(BuildContext context) {
    //final messageController = Get.find<MessageController>();
    //userId = messageController.getUserId();
    return GetBuilder<MessageController>(
        init: MessageController(),
        initState: (_) {
          //controller.getUserConversations();
          //controller.conversationsList.refresh();
        },
        builder: (controller) {
          return Stack(children: [
            GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Scaffold(
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
                      //const SearchBar(),
                      const SizedBox(
                        height: 30,
                      ),
                      /*Observable(
                        observable: controller.chatModels,
                        builder: (context, chatModelList) {
                          log(chatModelList.toString())
                          return chatModelList != null
                              ? Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        controller.conversationsList.length,
                                    itemBuilder: (context, index) =>
                                        MessageCard(
                                      chatModel:
                                          controller.chatModels.value![index],
                                      sourchat: userId,
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator());
                        },
                      )*/
                      controller.chatModels.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: controller.conversationsList.length,
                                itemBuilder: (context, index) => MessageCard(
                                  chatModel: controller.chatModels[index]!,
                                  sourchat: controller.userId,
                                ),
                              ),
                            )
                          : const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddConversation()),
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

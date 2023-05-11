import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:esprit_alumni_frontend/model/chat_model.dart';
import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:esprit_alumni_frontend/view/screens/chat/widgets/input_message.dart';
import 'package:esprit_alumni_frontend/view/screens/chat/widgets/own_message_card.dart';
import 'package:esprit_alumni_frontend/view/screens/chat/widgets/reply_message.dart';
import 'package:esprit_alumni_frontend/viewmodel/chat/controllers/conversation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:google_fonts/google_fonts.dart';

class ConversationScreen extends GetView<ConversationController> {
  const ConversationScreen(
      {Key? key, this.chatModel, required this.sourchat, this.profileImage})
      : super(key: key);
  final ChatModel? chatModel;
  final String? sourchat;
  final String? profileImage;

  @override
  Widget build(BuildContext context) {
    return chatModel != null
        ? GetBuilder<ConversationController>(
            init: ConversationController(),
            initState: (_) {
              controller.connect(sourchat ?? "", chatModel!.targetId ?? "");
              controller.getConversationMessages(
                  sourchat ?? "", chatModel!.targetId ?? "");
              controller.messagesList.refresh();
              controller.textEditingcontroller.clear();
            },
            builder: (controller) {
              return Stack(children: [
                GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Scaffold(
                      body: Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                gradient: AppColors.gradientBackground),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0,
                                    top: MediaQuery.of(context).size.height *
                                        0.06),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios_new,
                                        size: 24,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 13,
                                    ),
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundColor: AppColors.lightGray,
                                        child: chatModel?.image != ""
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.network(
                                                  chatModel!.image ?? "",
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : profileImage != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: Image.network(
                                                      profileImage ?? "",
                                                      height: 60,
                                                      width: 60,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : SvgPicture.asset(
                                                    "assets/images/Vector.svg",
                                                    width: 40,
                                                    height: 40,
                                                  )),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(chatModel?.name ?? "",
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.white),
                                        )),
                                    const SizedBox(width: 48),
                                    IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: AppColors.white,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Delete Conversation'),
                                                content: const Text(
                                                    'Are you sure you want to delete this conversation?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .redColor),
                                                    ),
                                                    onPressed: () {
                                                      controller
                                                          .deleteConversation(
                                                              sourchat ?? "",
                                                              chatModel!
                                                                      .targetId ??
                                                                  "");
                                                      Navigator.of(context)
                                                          .popUntil((route) => route
                                                              .isFirst); // navigate back to the first route (MessagesScreen)
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        })
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: Stack(children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                        color: AppColors.lightGray,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40))),
                                  ),
                                  WillPopScope(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Obx(() => controller
                                                  .messagesList.isNotEmpty
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  controller: controller
                                                      .scrollController,
                                                  itemCount: controller
                                                          .messagesList.length +
                                                      1,
                                                  itemBuilder:
                                                      (context, index) {
                                                    if (index ==
                                                        controller.messagesList
                                                            .length) {
                                                      return Container(
                                                        height: 50,
                                                      );
                                                    }
                                                    if (controller
                                                            .messagesList[index]
                                                            .sourceId ==
                                                        sourchat) {
                                                      return GestureDetector(
                                                          onLongPress: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title:
                                                                        const Text(
                                                                      "Delete Message ?",
                                                                      style: TextStyle(
                                                                          color:
                                                                              AppColors.redColor),
                                                                    ),
                                                                    content:
                                                                        const Text(
                                                                            "Are you sure you want to remove this message?"),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "Cancel",
                                                                          style:
                                                                              TextStyle(color: AppColors.black),
                                                                        ),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          String
                                                                              messageId =
                                                                              controller.messagesList[index].id!;
                                                                          controller
                                                                              .deleteMessage(messageId);
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "Yes",
                                                                          style:
                                                                              TextStyle(color: AppColors.redColor),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          },
                                                          child: OwnMessageCard(
                                                            message: controller
                                                                .messagesList[
                                                                    index]
                                                                .message,
                                                            time: controller
                                                                .formatDateTime(controller
                                                                        .messagesList[
                                                                            index]
                                                                        .createdAt ??
                                                                    ''),
                                                          ));
                                                    } else {
                                                      return GestureDetector(
                                                        onLongPress: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title:
                                                                      const Text(
                                                                    "Delete Message ?",
                                                                    style: TextStyle(
                                                                        color: AppColors
                                                                            .redColor),
                                                                  ),
                                                                  content:
                                                                      const Text(
                                                                          "Are you sure you want to remove this message?"),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "Cancel",
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColors.black),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        String messageId = controller
                                                                            .messagesList[index]
                                                                            .id!;
                                                                        controller
                                                                            .deleteMessage(messageId);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "Yes",
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColors.redColor),
                                                                      ),
                                                                    )
                                                                  ],
                                                                );
                                                              });
                                                        },
                                                        child: ReplyCard(
                                                          message: controller
                                                              .messagesList[
                                                                  index]
                                                              .message,
                                                          time: controller
                                                              .formatDateTime(controller
                                                                      .messagesList[
                                                                          index]
                                                                      .createdAt ??
                                                                  ''),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                )
                                              : const Center(
                                                  child: Text(
                                                      "No messages yet !"))),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: AppColors
                                                                .white),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        10.0,
                                                                    left: 10,
                                                                    top: 10),
                                                            child: InputMessage(
                                                              controller: controller
                                                                  .textEditingcontroller,
                                                              focusNode:
                                                                  controller
                                                                      .focusNode,
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .toggleSendButton(
                                                                        value);
                                                              },
                                                              toggleEmojiPicker:
                                                                  () => controller
                                                                      .toggleEmojiPicker(
                                                                          context),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: 60,
                                                            child: IconButton(
                                                                onPressed: () {
                                                                  if (controller
                                                                      .sendButton
                                                                      .value) {
                                                                    controller.sendMessage(
                                                                        controller
                                                                            .textEditingcontroller
                                                                            .text,
                                                                        sourchat ??
                                                                            "",
                                                                        chatModel!.targetId ??
                                                                            "",
                                                                        DateTime.now()
                                                                            .toString());
                                                                    controller
                                                                        .textEditingcontroller
                                                                        .clear();
                                                                  }
                                                                },
                                                                icon: SvgPicture
                                                                    .asset(
                                                                  "assets/images/send.svg",
                                                                  width: 30,
                                                                  height: 30,
                                                                )))
                                                      ],
                                                    ),
                                                  ),
                                                  _PickEmoji(
                                                    controller: controller
                                                        .textEditingcontroller,
                                                    emojiShowed:
                                                        controller.emojiShowed,
                                                  )
                                                ]))
                                      ],
                                    ),
                                    onWillPop: () {
                                      if (controller.emojiShowed) {
                                        controller.emojiShowed = false;
                                      } else {
                                        Navigator.pop(context);
                                      }
                                      return Future.value(false);
                                    },
                                  )
                                ]),
                              )
                            ],
                          ),
                        ],
                      ),
                    ))
              ]);
            })
        : const Text("No conversations yet");
  }
}

class _PickEmoji extends StatelessWidget {
  _PickEmoji({Key? key, required this.controller, required this.emojiShowed})
      : super(key: key);
  TextEditingController controller = TextEditingController();
  bool emojiShowed = false;
  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !emojiShowed,
      child: SizedBox(
        height: 250,
        child: EmojiPicker(
            textEditingController: controller,
            config: Config(
                emojiSizeMax: 32 *
                    (foundation.defaultTargetPlatform == TargetPlatform.iOS
                        ? 1.30
                        : 1.0),
                bgColor: const Color(0xFFF2F2F2),
                indicatorColor: AppColors.primaryColor,
                iconColor: Colors.grey,
                iconColorSelected: Colors.blue,
                backspaceColor: Colors.blue,
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: Colors.grey,
                noRecents: const Text(
                  'No Recents',
                  style: TextStyle(fontSize: 20, color: Colors.black26),
                  textAlign: TextAlign.center,
                ))),
      ),
    );
  }
}

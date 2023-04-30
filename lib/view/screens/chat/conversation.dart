import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:esprit_alumni_frontend/model/chat_model.dart';
import 'package:esprit_alumni_frontend/view/screens/chat/widgets/input_message.dart';
import 'package:esprit_alumni_frontend/view/screens/chat/widgets/own_message_card.dart';
import 'package:esprit_alumni_frontend/view/screens/chat/widgets/reply_message.dart';
import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:esprit_alumni_frontend/viewmodel/chat/controllers/conversation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';

class Conversation extends GetView<ConversationController> {
  const Conversation({Key? key, this.chatModel, required this.sourchat})
      : super(key: key);
  final ChatModel? chatModel;
  final String? sourchat;
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
            },
            builder: (controller) {
              return Stack(children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: AppColors.transparent,
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                          gradient: AppColors.gradientColor,
                        ),
                      ),
                      leadingWidth: 110,
                      leading: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.arrow_back,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.svgBackgroundClr,
                              child: chatModel!.image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        chatModel!.image ?? "",
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : SvgPicture.asset(
                                      "assets/images/person_icon.svg"),
                            ),
                          ],
                        ),
                      ),
                      title: Text(
                        chatModel!.name ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    body: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.converBackgroundClr,
                        /** 
                   * WillPopScope : ki tenzel 3al bouton back me to5rejch mel app 
                   * juste tetna7a el emoji picker khw*/
                        child: WillPopScope(
                          child: Column(
                            children: [
                              Expanded(
                                child: Obx(() => controller
                                        .messagesList.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        controller: controller.scrollController,
                                        itemCount:
                                            controller.messagesList.length + 1,
                                        itemBuilder: (context, index) {
                                          if (index ==
                                              controller.messagesList.length) {
                                            return Container(
                                              height: 50,
                                            );
                                          }
                                          if (controller.messagesList[index]
                                                  .sourceId ==
                                              sourchat) {
                                            return GestureDetector(
                                              onLongPress: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                          "Delete Message ?",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .redColor),
                                                        ),
                                                        content: const Text(
                                                            "Are you sure you want to remove this message?"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .black),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              String messageId =
                                                                  controller
                                                                      .messagesList[
                                                                          index]
                                                                      .id!;
                                                              controller
                                                                  .deleteMessage(
                                                                      messageId);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                              "Yes",
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .redColor),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: OwnMessageCard(
                                                  message: controller
                                                      .messagesList[index]
                                                      .message,
                                                  time: controller
                                                          .messagesList[index]
                                                          .time ??
                                                      ''
                                                  // controller.formatDateTime(controller
                                                  //         .messagesList[index].createdAt ??
                                                  //     ''),
                                                  ),
                                            );
                                          } else {
                                            return GestureDetector(
                                              onLongPress: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                          "Delete Message ?",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .redColor),
                                                        ),
                                                        content: const Text(
                                                            "Are you sure you want to remove this message?"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .black),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              String messageId =
                                                                  controller
                                                                      .messagesList[
                                                                          index]
                                                                      .id!;
                                                              controller
                                                                  .deleteMessage(
                                                                      messageId);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                              "Yes",
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .redColor),
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: ReplyCard(
                                                message: controller
                                                    .messagesList[index]
                                                    .message,
                                                time: controller.formatDateTime(
                                                    controller
                                                            .messagesList[index]
                                                            .createdAt ??
                                                        ''),
                                              ),
                                            );
                                          }
                                        },
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(
                                        color: AppColors.primaryColorDark,
                                      ))),
                              ),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: AppColors
                                                  .converBackgroundClr),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 6.0,
                                                          left: 10),
                                                  child: InputMessage(
                                                    controller: controller
                                                        .textEditingcontroller,
                                                    focusNode:
                                                        controller.focusNode,
                                                    onChanged: (value) {
                                                      if (value.isNotEmpty) {
                                                        controller.sendButton
                                                            .value = true;
                                                      } else {
                                                        controller.sendButton
                                                            .value = false;
                                                      }
                                                    },
                                                    toggleEmojiPicker: () =>
                                                        controller
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
                                                            .sendButton.value) {
                                                          controller.scrollController.animateTo(
                                                              controller
                                                                  .scrollController
                                                                  .position
                                                                  .maxScrollExtent,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          100),
                                                              curve: Curves
                                                                  .easeOut);
                                                          controller.sendMessage(
                                                              controller
                                                                  .textEditingcontroller
                                                                  .text,
                                                              sourchat ?? "",
                                                              chatModel!
                                                                      .targetId ??
                                                                  "",
                                                              DateTime.now()
                                                                  .toString()
                                                                  .substring(
                                                                      10, 16));
                                                          controller
                                                              .textEditingcontroller
                                                              .clear();
                                                        }
                                                      },
                                                      icon: SvgPicture.asset(
                                                          "assets/images/send_icon.svg")))
                                            ],
                                          ),
                                        ),
                                        _PickEmoji(
                                          controller:
                                              controller.textEditingcontroller,
                                          emojiShowed: controller.emojiShowed,
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
                        )),
                  ),
                ),
              ]);
            },
          )
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

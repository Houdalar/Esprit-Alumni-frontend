import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:esprit_alumni_frontend/Chat/controllers/conversation_controller.dart';
import 'package:esprit_alumni_frontend/Chat/widgets/input_message.dart';
import 'package:esprit_alumni_frontend/Chat/widgets/own_message_card.dart';
import 'package:esprit_alumni_frontend/Chat/widgets/reply_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'Models/chat_model.dart';
import 'design/app_colors.dart';

class Conversation extends StatefulWidget {
  const Conversation(
      {Key? key, required this.chatModel, required this.sourchat})
      : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  // final TextEditingController _controller = TextEditingController();
  // final ScrollController _scrollController = ScrollController();
//  final FocusNode _focusNode = FocusNode();
  //bool emojiShowed = false;
  // late io.Socket socket;
  // bool sendButton = false;
  // List<MessageModel> messagesList = [];

  final controller = Get.put(ConversationController());

  @override
  void initState() {
    super.initState();
    controller.connect(widget.sourchat.id);
    controller.getConversationMessages(widget.sourchat.id, widget.chatModel.id);

    //! Done
    // _focusNode.addListener(() {
    //   if (_focusNode.hasFocus) {
    //     setState(() {
    //       emojiShowed = false;
    //     });
    //   }
    // });
  }

  //! Done

  /// connect the app to the socket.io server
  /// so every app will be treated as a socket.io client
  // void connect() {
  //   socket = io.io("http://192.168.1.149:3000", <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //   });
  //connecter le socket server manuellement
  //   socket.connect();
  //   socket.emit("signin", widget.sourchat.id);
  //   socket.onConnect((data) {
  //     print("Connected");
  //     socket.on("message", (msg) {
  //       print(msg);
  //       //add the msg to the messages' list and specify its type as a destination msg
  //       setMessage("destination", msg["message"]);
  //       //scroll to the bottom of the listview
  //       _scrollController.animateTo(_scrollController.position.maxScrollExtent,
  //           duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
  //     });
  //   });
  //   print(socket.connected);
  // }

//! Done
  // void sendMessage(String message, int sourceId, int targetId) {
  //   //add the msg to the messages' list and specify its type as a source msg
  //   setMessage("source", message);
  //   //send a json objetct from the source to the target
  //   //"message" is the event name and with its help we'll listen to it on the socket server
  //   socket.emit("message", {"message": message, "sourceId": sourceId, "targetId": targetId});
  // }

//! Done
  // //whenever we'll send a msg or receive a message we'll add it to the messages' list
  // void setMessage(String type, String msg) {
  //   MessageModel messsageModel = MessageModel(type: type, message: msg, time: DateTime.now().toString().substring(10, 16));
  //   setState(() {
  //     messages.add(messsageModel);
  //   });
  // }

//! Done

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   _focusNode.dispose();
  //   super.dispose();
  // }

//! Done
  // void toggleEmojiPicker() {
  //   setState(() {
  //     controller.emojiShowed = !controller.emojiShowed;
  //     FocusScope.of(context).unfocus();
  //   });
  // }

//! Done
  // void onEmojiSelected(Emoji emoji) {
  //   _controller.text += emoji.emoji;
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConversationController>(
      init: ConversationController(),
      initState: (_) {},
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
                          child: SvgPicture.asset(
                            widget.chatModel.isGroup
                                ? "assets/images/groups_icon.svg"
                                : "assets/images/person_icon.svg",
                            color: AppColors.primaryColorDark,
                            height: 28,
                            width: 28,
                          )),
                    ],
                  ),
                ),
                title: Text(
                  widget.chatModel.name,
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
                          // height: MediaQuery.of(context).size.height - 158,
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: controller.scrollController,
                            itemCount: controller.messagesList.length + 1,
                            itemBuilder: (context, index) {
                              if (index == controller.messagesList.length) {
                                return Container(
                                  height: 50,
                                );
                              }
                              if (controller.messagesList[index].sourceId ==
                                  widget.sourchat.id) {
                                return OwnMessageCard(
                                  message:
                                      controller.messagesList[index].message,
                                  time: controller.formatDateTime(controller
                                          .messagesList[index].createdAt ??
                                      ''),
                                );
                              } else {
                                return ReplyCard(
                                  message:
                                      controller.messagesList[index].message,
                                  time: controller.formatDateTime(controller
                                          .messagesList[index].createdAt ??
                                      ''),
                                );
                              }
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: AppColors.converBackgroundClr),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                55,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 6.0, left: 10),
                                          child: InputMessage(
                                            controller: controller
                                                .textEditingcontroller,
                                            focusNode: controller.focusNode,
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                controller.sendButton.value =
                                                    true;
                                              } else {
                                                controller.sendButton.value =
                                                    false;
                                              }
                                            },
                                            toggleEmojiPicker: () => controller
                                                .toggleEmojiPicker(context),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5, right: 10),
                                            child: controller.sendButton.value
                                                ? IconButton(
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
                                                            curve:
                                                                Curves.easeOut);
                                                        controller.sendMessage(
                                                            controller
                                                                .textEditingcontroller
                                                                .text,
                                                            widget.sourchat.id,
                                                            widget
                                                                .chatModel.id);
                                                        controller
                                                            .textEditingcontroller
                                                            .clear();

                                                        controller.sendButton
                                                            .value = false;
                                                      }
                                                    },
                                                    icon: SvgPicture.asset(
                                                        "assets/images/send_icon.svg"))
                                                : IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {},
                                                    icon: SvgPicture.asset(
                                                      "assets/images/mic_icon.svg",
                                                      width: 15,
                                                    ),
                                                    //iconSize: 50,
                                                  )),
                                      ),
                                    ],
                                  ),
                                ),
                                _PickEmoji(
                                  controller: controller.textEditingcontroller,
                                  emojiShowed: controller.emojiShowed,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    onWillPop: () {
                      if (controller.emojiShowed) {
                        setState(() {
                          controller.emojiShowed = false;
                        });
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
    );
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
            ),
          ),
        ),
      ),
    );
  }
}

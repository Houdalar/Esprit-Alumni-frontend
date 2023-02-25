import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:esprit_alumni_frontend/Chat/widgets/own_message_card.dart';
import 'package:esprit_alumni_frontend/Chat/widgets/reply_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'Models/chat_model.dart';
import 'design/app_colors.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

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
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool emojiShowed = false;
  late io.Socket socket;
  bool sendButton = false;

  @override
  void initState() {
    super.initState();
    connect();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          emojiShowed = false;
        });
      }
    });
  }

  void connect() {
    socket = io.io("http://192.168.43.241:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    //connecter le socket manuellement
    socket.connect();
    socket.emit("/test", "Hello world !");
    socket.onConnect((data) => print("Connected"));
    print(socket.connected);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void toggleEmojiPicker() {
    setState(() {
      emojiShowed = !emojiShowed;
    });
  }

  void onEmojiSelected(Emoji emoji) {
    _controller.text += emoji.emoji;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
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
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 158,
                      child: ListView(
                        shrinkWrap: true,
                        children: const [
                          OwnMessageCard(message: "Bonsoir !", time: "23:44"),
                          ReplyCard(message: "Bonsoir Ines !", time: "23:50"),
                          OwnMessageCard(
                              message:
                                  "HjdpqjsyE <QBSDLIzv nbfvobdfopegoidf qfbliue vqmvkqmsv mqosvnlishfv qsvm oisbvli",
                              time: "23:51"),
                          OwnMessageCard(message: "Bonsoir !", time: "23:44"),
                          ReplyCard(message: "Bonsoir Ines !", time: "23:50"),
                          OwnMessageCard(
                              message:
                                  "HjdpqjsyE <QBSDLIzv nbfvobdfopegoidf qfbliue vqmvkqmsv mqosvnlishfv qsvm oisbvli",
                              time: "23:51"),
                          OwnMessageCard(message: "Bonsoir !", time: "23:44"),
                          ReplyCard(message: "Bonsoir Ines !", time: "23:50"),
                          OwnMessageCard(
                              message:
                                  "HjdpqjsyE <QBSDLIzv nbfvobdfopegoidf qfbliue vqmvkqmsv mqosvnlishfv qsvm oisbvli",
                              time: "23:51"),
                          OwnMessageCard(message: "Bonsoir !", time: "23:44"),
                          ReplyCard(message: "Bonsoir Ines !", time: "23:50"),
                          OwnMessageCard(
                              message:
                                  "HjdpqjsyE <QBSDLIzv nbfvobdfopegoidf qfbliue vqmvkqmsv mqosvnlishfv qsvm oisbvli",
                              time: "23:51"),
                          OwnMessageCard(message: "Bonsoir !", time: "23:44"),
                          ReplyCard(message: "Bonsoir Ines !", time: "23:50"),
                          OwnMessageCard(
                              message:
                                  "HjdpqjsyE <QBSDLIzv nbfvobdfopegoidf qfbliue vqmvkqmsv mqosvnlishfv qsvm oisbvli",
                              time: "23:51"),
                          OwnMessageCard(message: "Bonsoir !", time: "23:44"),
                          ReplyCard(message: "Bonsoir Ines !", time: "23:50"),
                          OwnMessageCard(
                              message:
                                  "HjdpqjsyE <QBSDLIzv nbfvobdfopegoidf qfbliue vqmvkqmsv mqosvnlishfv qsvm oisbvli",
                              time: "23:51"),
                          OwnMessageCard(message: "Bonsoir !", time: "23:44"),
                          ReplyCard(message: "Bonsoir Ines !", time: "23:50"),
                          OwnMessageCard(
                              message:
                                  "HjdpqjsyE <QBSDLIzv nbfvobdfopegoidf qfbliue vqmvkqmsv mqosvnlishfv qsvm oisbvli",
                              time: "23:51"),
                          OwnMessageCard(message: "Bonsoir !", time: "23:44"),
                          ReplyCard(message: "Bonsoir Ines !", time: "23:50"),
                          OwnMessageCard(
                              message:
                                  "HjdpqjsyE <QBSDLIzv nbfvobdfopegoidf qfbliue vqmvkqmsv mqosvnlishfv qsvm oisbvli",
                              time: "23:51"),
                          OwnMessageCard(message: "Bonsoir !", time: "23:44"),
                          ReplyCard(message: "Bonsoir Ines !", time: "23:50"),
                          OwnMessageCard(
                              message:
                                  "HjdpqjsyE <QBSDLIzv nbfvobdfopegoidf qfbliue vqmvkqmsv mqosvnlishfv qsvm oisbvli",
                              time: "23:51"),
                          OwnMessageCard(message: "Bonsoir !", time: "23:44"),
                          ReplyCard(message: "Bonsoir Ines !", time: "23:50"),
                          OwnMessageCard(
                              message:
                                  "HjdpqjsyE <QBSDLIzv nbfvobdfopegoidf qfbliue vqmvkqmsv mqosvnlishfv qsvm oisbvli",
                              time: "23:51"),
                          OwnMessageCard(message: "Bonsoir !", time: "23:44"),
                          ReplyCard(message: "Bonsoir Ines !", time: "23:50"),
                          OwnMessageCard(
                              message:
                                  "HjdpqjsyE <QBSDLIzv nbfvobdfopegoidf qfbliue vqmvkqmsv mqosvnlishfv qsvm oisbvli",
                              time: "23:51"),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 55,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 6.0),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: _focusNode,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                        fillColor: AppColors.transparent,
                                        hintText: "Type a message ",
                                        hintStyle:
                                            const TextStyle(fontSize: 13.5),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(31),
                                        ),
                                        prefixIcon: IconButton(
                                            onPressed: toggleEmojiPicker,
                                            icon: const Icon(
                                              Icons.emoji_emotions,
                                              color: AppColors.primaryColor,
                                            )),
                                        suffixIcon: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.camera_alt,
                                              color: AppColors.primaryColor,
                                            )),
                                        contentPadding:
                                            const EdgeInsets.all(5)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor:
                                          AppColors.converBackgroundClr,
                                      child:
                                          /*SvgPicture.asset(
                                        "assets/images/send_icon.svg")),*/
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.mic,
                                                color: AppColors.primaryColor,
                                              )))),
                            ],
                          ),
                          Offstage(
                            offstage: !emojiShowed,
                            child: SizedBox(
                              height: 250,
                              child: EmojiPicker(
                                textEditingController: _controller,
                                config: Config(
                                  columns: 7,
                                  emojiSizeMax: 32 *
                                      (foundation.defaultTargetPlatform ==
                                              TargetPlatform.iOS
                                          ? 1.30
                                          : 1.0),
                                  verticalSpacing: 0,
                                  horizontalSpacing: 0,
                                  gridPadding: EdgeInsets.zero,
                                  initCategory: Category.RECENT,
                                  bgColor: const Color(0xFFF2F2F2),
                                  indicatorColor: Colors.blue,
                                  iconColor: Colors.grey,
                                  iconColorSelected: Colors.blue,
                                  backspaceColor: Colors.blue,
                                  skinToneDialogBgColor: Colors.white,
                                  skinToneIndicatorColor: Colors.grey,
                                  enableSkinTones: true,
                                  showRecentsTab: true,
                                  recentsLimit: 28,
                                  replaceEmojiOnLimitExceed: false,
                                  noRecents: const Text(
                                    'No Recents',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black26),
                                    textAlign: TextAlign.center,
                                  ),
                                  loadingIndicator: const SizedBox.shrink(),
                                  tabIndicatorAnimDuration: kTabScrollDuration,
                                  categoryIcons: const CategoryIcons(),
                                  buttonMode: ButtonMode.MATERIAL,
                                  checkPlatformCompatibility: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              onWillPop: () {
                if (emojiShowed) {
                  setState(() {
                    emojiShowed = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            )),
      ),
    ]);
  }
}

import 'package:esprit_alumni_frontend/Chat/messages.dart';
import 'package:flutter/material.dart';

import 'Chat/Models/chat_model.dart';
import 'Chat/design/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Ines Said",
      isGroup: false,
      currentMessage: "Hi Houda",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name: "Houda Lariani",
      isGroup: false,
      currentMessage: "Hi Ines",
      time: "13:00",
      icon: "person.svg",
      id: 2,
    ),
    // ChatModel(
    //   name: "PIM Group",
    //   isGroup: true,
    //   currentMessage: "chats feature",
    //   time: "2:00",
    //   icon: "group.svg",
    // ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chatmodels.length,
          itemBuilder: (contex, index) => InkWell(
              onTap: () {
                sourceChat = chatmodels.removeAt(index);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => Messages(
                              chatmodels: chatmodels,
                              sourcChat: sourceChat,
                            )));
              },
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 23,
                  backgroundColor: AppColors.svgBackgroundClr,
                  child: Icon(
                    Icons.person,
                    size: 26,
                    color: AppColors.primaryColorDark,
                  ),
                ),
                title: Text(
                  chatmodels[index].name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))),
    );
  }
}

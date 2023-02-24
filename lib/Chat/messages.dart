import 'package:flutter/material.dart';

import 'design/app_colors.dart';
import 'widgets/search_bar.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: const [
        Padding(
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
        SearchBar(),
        SizedBox(
          height: 30,
        ),
      ],
    ));
  }
}

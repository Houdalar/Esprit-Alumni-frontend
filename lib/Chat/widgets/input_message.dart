import 'package:flutter/material.dart';

import '../design/app_colors.dart';

class InputMessage extends StatefulWidget {
  const InputMessage({Key? key}) : super(key: key);

  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  static bool show = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 1,
      decoration: InputDecoration(
          hintText: "Type a message ",
          hintStyle: const TextStyle(fontSize: 13.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(31),
          ),
          prefixIcon: IconButton(
              onPressed: () {
                setState(() {
                  show = !show;
                });
              },
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
          contentPadding: const EdgeInsets.all(5)),
    );
  }
}

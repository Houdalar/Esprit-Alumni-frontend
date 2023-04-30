import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:flutter/material.dart';

class InputMessage extends StatefulWidget {
  InputMessage(
      {Key? key,
      required this.controller,
      required this.focusNode,
      required this.toggleEmojiPicker,
      required this.onChanged})
      : super(key: key);
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  void Function()? toggleEmojiPicker;
  void Function(String)? onChanged;
  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  static bool show = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 1,
      decoration: InputDecoration(
          hintText: "Type a message ",
          hintStyle: const TextStyle(fontSize: 13.5),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(31),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(31),
          ),
          prefixIcon: IconButton(
              onPressed: widget.toggleEmojiPicker,
              icon: const Icon(
                Icons.emoji_emotions,
                color: AppColors.primaryColor,
              )),
          // suffixIcon: IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.camera_alt,
          //       color: AppColors.primaryColor,
          //     )),
          contentPadding: const EdgeInsets.all(5)),
    );
  }
}

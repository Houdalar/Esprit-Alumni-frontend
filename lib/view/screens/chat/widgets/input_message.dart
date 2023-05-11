import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          hintText: "Start typing... ",
          hintStyle: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 12,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(31),
              borderSide: BorderSide.none),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(31),
              borderSide: BorderSide.none),
          prefixIcon: IconButton(
              onPressed: widget.toggleEmojiPicker,
              icon: const Icon(
                Icons.emoji_emotions,
                color: Color.fromARGB(255, 184, 35, 35),
              )),
          fillColor: const Color.fromARGB(255, 240, 240, 240),
          filled: true,
          contentPadding: const EdgeInsets.all(5)),
      cursorColor: AppColors.primaryColorDark,
    );
  }
}

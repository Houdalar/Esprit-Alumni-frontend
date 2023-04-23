import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'ceatePostDialog.dart';

class CreatePost extends StatefulWidget {
  final String? profileimage;
  final String? username;
  const CreatePost(this.profileimage, this.username, {Key? key})
      : super(key: key);
  @override
  CreatePostState createState() => CreatePostState();
}

class CreatePostState extends State<CreatePost> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    pickImage(ImageSource gallery) async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      final imageTemporary = File(image.path);
      return imageTemporary;
    }

    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Card(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(widget.profileimage!),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 20, 20, 20),
                              content: SingleChildScrollView(
                                child: PostCreateComponent(
                                    widget.username, widget.profileimage),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          'What\'s on your mind, ${widget.username}?',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                //width: double.infinity,
                child: const Divider(
                  color: Colors.grey,
                  height: 2.0,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            focusNode.unfocus();
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          icon: const Icon(
                            Icons.emoji_emotions_outlined,
                            color: Color.fromARGB(255, 217, 150, 5),
                            size: 30,
                          ),
                        ),
                        const Text(
                          'Feeling/Activity',
                          style: TextStyle(
                            color: AppColors.darkgray,
                            fontSize: 16.0,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            focusNode.unfocus();
                            setState(() {
                              _isExpanded = false;
                            });
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  content: SingleChildScrollView(
                                    child: PostCreateComponent(
                                        widget.username, widget.profileimage),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.image,
                              color: Color.fromARGB(255, 4, 160, 87)),
                        ),
                        const Text(
                          'Photo',
                          style: TextStyle(
                            color: AppColors.darkgray,
                            fontSize: 16.0,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            focusNode.unfocus();
                            setState(() {
                              _isExpanded = false;
                            });
                            pickImage(ImageSource.camera);
                          },
                          icon: const Icon(Icons.camera_alt,
                              color: AppColors.primary),
                        ),
                        const Text(
                          'Camera',
                          style: TextStyle(
                            color: AppColors.darkgray,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_isExpanded)
                EmojiPicker(
                  onEmojiSelected: (emoji, category) {},
                ),
            ],
          ),
        ),
      ),
    );
  }
}

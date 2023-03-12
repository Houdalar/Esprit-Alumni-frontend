import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  final String? profileimage;
  const CreatePost(this.profileimage, {Key? key}) : super(key: key);
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _textEditingController = TextEditingController();

  String _selectedCategory = 'ITC';
  List<String> _categories = ['ITC', 'Internship', 'Ask', 'Job'];

  bool _isExpanded = false;
  bool _isExpanded1 = false;

  File _image = File('');

  @override
  Widget build(BuildContext context) {
    final _focusNode = FocusNode();
    _pickImage(ImageSource gallery) async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      final imageTemporary = File(image.path);
      return imageTemporary;
    }

    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
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
                            return Dialog(
                              child: Container(
                                height: 300,
                                width: 300,
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20.0,
                                            backgroundImage: NetworkImage(
                                                widget.profileimage!),
                                          ),
                                          const SizedBox(width: 12.0),
                                          Text("user"),
                                        ],
                                      ),
                                      const SizedBox(height: 20.0),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                controller:
                                                    _textEditingController,
                                                focusNode: _focusNode,
                                                maxLines: null,
                                                decoration: InputDecoration(
                                                  hintText: "What's new ?",
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  EmojiPicker(
                                                    onEmojiSelected:
                                                        (category, emoji) {
                                                      _textEditingController
                                                              .text =
                                                          _textEditingController
                                                                  .text +
                                                              emoji.emoji;
                                                    },
                                                  );
                                                  _isExpanded1 = !_isExpanded1;
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.emoji_emotions,
                                                color: Colors.grey,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15.0),
                                      Container(
                                        child: Column(children: [
                                          Container(
                                            height: 200,
                                            width: 200,
                                            child: _image == null
                                                ? IconButton(
                                                    onPressed: () {
                                                      _pickImage(
                                                          ImageSource.gallery);
                                                      setState(() {
                                                        _image = _pickImage(
                                                                ImageSource
                                                                    .gallery)
                                                            as File;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.add_a_photo))
                                                : Image.file(_image),
                                          ),
                                          Text(
                                            "Add a photo",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16.0),
                                          ),
                                          Spacer(),
                                          DropdownButton(
                                            items: _categories.map((category) {
                                              return DropdownMenuItem(
                                                child: Text(category),
                                                value: category,
                                              );
                                            }).toList(),
                                            onChanged:
                                                (String? selectedCategory) {
                                              setState(() {
                                                _selectedCategory =
                                                    selectedCategory!;
                                              });
                                            },
                                            value: _selectedCategory,
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
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
                        child: const Text(
                          'What\'s on your mind?',
                          style: TextStyle(
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
                width: double.infinity,
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
                            _focusNode.unfocus();
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
                            _focusNode.unfocus();
                            setState(() {
                              _isExpanded = false;
                            });
                            _pickImage(ImageSource.gallery);
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
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            _focusNode.unfocus();
                            setState(() {
                              _isExpanded = false;
                            });
                            _pickImage(ImageSource.camera);
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

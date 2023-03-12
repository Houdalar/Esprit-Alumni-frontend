import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/*class CreatePost extends StatefulWidget {
  final String? profileimage;
  const CreatePost(this.profileimage, {Key? key}) : super(key: key);
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _textEditingController = TextEditingController();

  String _selectedCategory = 'Category 1';
  List<String> _categories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4'
  ];

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(2, 10, 2, 0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(widget.profileimage!),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind?',
                      border: InputBorder.none,
                    ),
                    minLines: 1,
                    maxLines: 5,
                    onTap: () {
                      setState(() {
                        _isExpanded = true;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // TODO: Implement post creation logic
                    _textEditingController.clear();
                  },
                ),
              ],
            ),
            if (_isExpanded)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 12.0),
                  DropdownButtonFormField(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: _categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value as String;
                      });
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';

/*class CreatePost extends StatefulWidget {
  final String? profileimage;
  const CreatePost(this.profileimage, {Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _textEditingController = TextEditingController();
  String _selectedCategory = 'Category 1';
  List<String> _categories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4'
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(widget.profileimage!),
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        'Username',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind?',
                      border: InputBorder.none,
                    ),
                    minLines: 1,
                    maxLines: 5,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Implement image upload logic
                        },
                        icon: Icon(Icons.send),
                        label: Text('Add Photo'),
                      ),
                      IconButton(
                        icon: Icon(Icons.emoji_emotions),
                        onPressed: () {
                          // TODO: Implement emoji picker logic
                        },
                      ),
                      DropdownButton<String>(
                        value: _selectedCategory,
                        items: _categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategory = newValue!;
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Implement post creation logic
                          Navigator.pop(context);
                        },
                        child: Text('Post'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Card(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 10, 2, 0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(widget.profileimage!),
              ),
              SizedBox(width: 12.0),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'What\'s on your mind?',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
                minLines: 1,
                maxLines: 5,
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  // TODO: Implement image upload logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

class CreatePost extends StatefulWidget {
  final String? profileImage;
  const CreatePost(this.profileImage, {Key? key}) : super(key: key);
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String _selectedCategory = 'Category 1';
  List<String> _categories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4'
  ];

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
        setState(() {
          _isExpanded = false;
        });
      },
      child: Card(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 10, 2, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(widget.profileImage!),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'What\'s on your mind?',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (_isExpanded)
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 12.0),
                                    DropdownButtonFormField(
                                      value: _selectedCategory,
                                      decoration: const InputDecoration(
                                        labelText: 'Category',
                                        border: OutlineInputBorder(),
                                      ),
                                      items: _categories.map((category) {
                                        return DropdownMenuItem(
                                          value: category,
                                          child: Text(category),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedCategory = value as String;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 12.0),
                                    TextField(
                                      focusNode: _focusNode,
                                      controller: _textEditingController,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                        hintText: 'What\'s on your mind?',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.photo),
                                          onPressed: () {
                                            // TODO: Implement photo upload logic
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              Icons.emoji_emotions_outlined),
                                          onPressed: () {
                                            // TODO: Implement emoji picker logic
                                          },
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            // TODO: Implement post creation logic
                                            _textEditingController.clear();
                                            setState(() {
                                              _isExpanded = false;
                                            });
                                          },
                                          child: const Text('Post'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

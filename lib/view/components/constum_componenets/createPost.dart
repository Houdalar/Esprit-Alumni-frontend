import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
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
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
}

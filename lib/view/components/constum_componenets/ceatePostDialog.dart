import 'package:flutter/material.dart';

class PostCreateComponent extends StatefulWidget {
  @override
  _PostCreateComponentState createState() => _PostCreateComponentState();
}

class _PostCreateComponentState extends State<PostCreateComponent> {
  // State variables for the component
  String? _category;
  String? _description;
  String? _imagePath;
  bool _imageSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // User profile picture and name
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://example.com/profile.jpg'),
            ),
            SizedBox(width: 10),
            Text('John Doe'),
          ],
        ),

        SizedBox(height: 20),

        // Image picker box
        GestureDetector(
          onTap: () {
            // TODO: open image picker dialog
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: _imageSelected
                ? Image.network(_imagePath!, fit: BoxFit.cover)
                : Icon(Icons.photo_camera),
          ),
        ),

        SizedBox(height: 20),

        // Category dropdown
        DropdownButton<String>(
          value: _category,
          onChanged: (value) {
            setState(() {
              _category = value;
            });
          },
          items: [
            DropdownMenuItem(child: Text('Category 1'), value: 'cat1'),
            DropdownMenuItem(child: Text('Category 2'), value: 'cat2'),
            DropdownMenuItem(child: Text('Category 3'), value: 'cat3'),
          ],
        ),

        SizedBox(height: 20),

        // Description text field
        TextField(
          decoration: InputDecoration(hintText: 'Enter description'),
          onChanged: (value) {
            setState(() {
              _description = value;
            });
          },
        ),

        SizedBox(height: 20),

        // Post button
        ElevatedButton(
          onPressed: () {
            // TODO: create post with _category, _description, and _imagePath
            setState(() {
              _category = null;
              _description = null;
              _imagePath = null;
              _imageSelected = false;
            });
          },
          child: Text('Post'),
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:esprit_alumni_frontend/viewmodel/profileViewModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostCreateComponent extends StatefulWidget {
  final String? username;
  final String? profilePic;
  const PostCreateComponent(this.username, this.profilePic, {Key? key})
      : super(key: key);
  @override
  PostCreateComponentState createState() => PostCreateComponentState();
}

class PostCreateComponentState extends State<PostCreateComponent> {
  // State variables for the component
  String? _category;
  String? _description;
  String? _imagePath;
  bool _imageSelected = false;
  File? _imageFile;
  String token = "";
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // User profile picture and name
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.profilePic!),
            ),
            const SizedBox(width: 10),
            Text(
              widget.username!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            controller: _descriptionController,
            keyboardType: TextInputType.multiline, // Add this line
            maxLines: null, // Add this line
            decoration: InputDecoration(
              hintText: 'what\'s on your mind, ${widget.username}?',
              border: InputBorder.none,
              hintMaxLines: 4,
            ),
          ),
        ),

        const SizedBox(height: 20),
        const SizedBox(height: 20),

        // Image picker box
        GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: Stack(
              children: [
                _imageSelected
                    ? Center(
                        child: Image(
                          image: MemoryImage(_imageFile!.readAsBytesSync()),
                          fit: BoxFit.cover,
                          //width: double.infinity,
                        ),
                      )
                    : const SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.grey,
                        ),
                      ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () async {
                        final pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (pickedFile == null) return;
                        final imageTemporary = File(pickedFile.path);
                        setState(() {
                          _imageFile = imageTemporary;
                          _imageSelected = true;
                        });
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Category dropdown
        DropdownButtonFormField<String>(
          value: _category,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            hintText: 'Select a category',
            hintStyle: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(
                color: AppColors.primaryDark,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(
                color: AppColors.primaryDark,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(
                color: AppColors.primaryDark,
                width: 1,
              ),
            ),
          ),
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.primaryDark),
          iconSize: 24,
          isExpanded: true,
          items: const [
            DropdownMenuItem(value: 'General', child: Text('General')),
            DropdownMenuItem(value: 'job', child: Text('job')),
            DropdownMenuItem(value: 'internship', child: Text('internship')),
            DropdownMenuItem(value: 'event', child: Text('event')),
            DropdownMenuItem(value: 'Esprit', child: Text('Esprit')),
            DropdownMenuItem(value: 'other', child: Text('other')),
          ],
          onChanged: (value) {
            setState(() {
              _category = value;
            });
          },
        ),

        const SizedBox(height: 20),
        // Post button
        SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                token = prefs.getString("userId") ?? "";
              });
              ProfileViewModel.createPost(
                token,
                _descriptionController
                    .text, // Use the text from the TextEditingController
                _category!,
                _imageFile,
                context,
              );
              setState(() {
                _category = null;
                _description = null;
                _imagePath = null;
                _imageSelected = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: const Text('Post'),
          ),
        ),
      ],
    );
  }
}

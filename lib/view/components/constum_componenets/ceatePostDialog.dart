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
  _PostCreateComponentState createState() => _PostCreateComponentState();
}

class _PostCreateComponentState extends State<PostCreateComponent> {
  // State variables for the component
  String? _category;
  String? _description;
  String? _imagePath;
  bool _imageSelected = false;
  File? _imageFile;
  String token = "";

  @override
  void initState() {
    super.initState();
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
            SizedBox(width: 10),
            Text(
              widget.username!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
              hintText: 'what\'s on your mind, ${widget.username}?',
              border: InputBorder.none,
              hintMaxLines: 4),
          onChanged: (value) {
            setState(() {
              _description = value;
            });
          },
        ),

        SizedBox(height: 20),
        SizedBox(height: 20),

        // Image picker box
        GestureDetector(
          onTap: () {
            // TODO: open image picker dialog
          },
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
                    : Container(
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
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () async {
                        final pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (pickedFile == null) return null;
                        final imageTemporary = File(pickedFile.path);
                        setState(() {
                          _imageFile = imageTemporary;
                          _imageSelected = true;
                        });
                      },
                      icon: Icon(Icons.add_a_photo),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 20),

        // Category dropdown
        DropdownButtonFormField<String>(
          value: _category,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
          icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryDark),
          iconSize: 24,
          isExpanded: true,
          items: [
            DropdownMenuItem(child: Text('General'), value: 'General'),
            DropdownMenuItem(child: Text('job'), value: 'job'),
            DropdownMenuItem(child: Text('internship'), value: 'internship'),
            DropdownMenuItem(child: Text('event'), value: 'event'),
            DropdownMenuItem(child: Text('Esprit'), value: 'Esprit'),
            DropdownMenuItem(child: Text('other'), value: 'other'),
          ],
          onChanged: (value) {
            setState(() {
              _category = value;
            });
          },
        ),

        SizedBox(height: 20),
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
                _description ?? "      ",
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
              primary: AppColors.primaryDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Text('Post'),
          ),
        ),
      ],
    );
  }
}

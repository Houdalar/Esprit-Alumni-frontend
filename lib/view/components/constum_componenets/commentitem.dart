import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../viewmodel/profileViewModel.dart';

class CommentItem extends StatefulWidget {
  final String username;
  final String profilePictureUrl;
  final String comment;
  final String timestamp;
  int likes;
  final String userId;
  final String commentId;
  final List<String> likesList;

  CommentItem({
    required this.username,
    required this.profilePictureUrl,
    required this.comment,
    required this.timestamp,
    required this.likes,
    required this.userId,
    required this.commentId,
    required this.likesList,
  });

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool _isLiked = false;
  late SharedPreferences _prefs;
  String? token = "";

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      token = _prefs.getString('userId') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _isLiked = widget.likesList.contains(widget.userId);
    _initializePrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.profilePictureUrl),
            radius: 24.0,
          ),
          SizedBox(width: 5.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 0.0,
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(widget.comment,
                              style: TextStyle(fontSize: 16, height: 1.5)),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 2.0),
                    IconButton(
                      icon: _isLiked ?? false
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 20,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                              size: 20,
                            ),
                      onPressed: () async {
                        if (token != null) {
                          print("token is ${token}");
                          final updatedComment =
                              await ProfileViewModel.likeComment(
                            token!,
                            widget.commentId,
                            context,
                          );
                          if (updatedComment != null) {
                            setState(() {
                              _isLiked = !_isLiked;
                              widget.likes = updatedComment.numberOfLikes;
                            });
                          }
                        } else {
                          print("Token is not initialized yet");
                        }
                      },
                    ),
                    Text(widget.likes.toString(),
                        style: TextStyle(fontSize: 15.5)),
                    SizedBox(width: 10.0),
                    Text(widget.timestamp,
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

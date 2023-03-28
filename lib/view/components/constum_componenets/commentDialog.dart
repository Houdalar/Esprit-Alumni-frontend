import 'package:esprit_alumni_frontend/model/profilemodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../model/commentModel.dart';
import '../../../viewmodel/profileViewModel.dart';
import '../themes/colors.dart';
import 'commentitem.dart';

class CommentDialog extends StatefulWidget {
  final String? postId;
  late SharedPreferences _prefs;

  CommentDialog({required this.postId});

  @override
  _CommentDialogState createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  List<CommentItem> _comments = []; // Initialize an empty list of comments
  late SharedPreferences _prefs;
  String _profilePic = "http://10.0.2.2:8081/posts/profile.png";
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _commentController = TextEditingController();

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _profilePic = _prefs.getString('profile_image') ??
          "http://10.0.2.2:8081/posts/profile.png";
    });
  }

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CommentModel>>(
      future: ProfileViewModel.getComments(widget.postId!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _comments = snapshot.data!.map((comment) {
            return CommentItem(
              username: comment.owner["username"],
              profilePictureUrl: comment.owner["profile_image"],
              comment: comment.content,
              timestamp: comment.elapsedTimeString,
              likes: comment.numberOfLikes,
            );
          }).toList();
          return AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: _comments.length,
                      itemBuilder: (context, index) {
                        final comment = _comments[index];
                        print(_profilePic);
                        return CommentItem(
                          username: comment.username,
                          profilePictureUrl: comment.profilePictureUrl,
                          comment: comment.comment,
                          timestamp: comment.timestamp,
                          likes: comment.likes,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 5),
                  Divider(),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(_profilePic),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: TextFormField(
                              controller: _commentController,
                              decoration: InputDecoration(
                                hintText: 'Add a comment...',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final newComment = await ProfileViewModel.addComment(
                            _prefs.getString('userId')!,
                            widget.postId!,
                            _commentController.text,
                            context,
                          );
                          if (newComment != null) {
                            setState(() {
                              _comments.insert(
                                0,
                                CommentItem(
                                  username: newComment.owner["username"],
                                  profilePictureUrl:
                                      newComment.owner["profile_image"],
                                  comment: newComment.content,
                                  timestamp: newComment.elapsedTimeString,
                                  likes: newComment.numberOfLikes,
                                ),
                              );
                            });
                            _commentController.clear();
                            _scrollController.animateTo(
                              0.0,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );
                          }
                        },
                        icon: Icon(Icons.send),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return AlertDialog(
            title: const Text(
              'Network error',
              style: TextStyle(color: AppColors.primary),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'media/No connection-bro.png',
                  height: 300,
                  width: 300,
                ),
                const Text(
                    'Please check your internet connection and try again!'),
              ],
            ),
          );
        } else {
          return const AlertDialog(
            content: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

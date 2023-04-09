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

  final Function() onCommentAdded;
  final Function() onCommentDeleted;

  CommentDialog(
      {required this.postId,
      required this.onCommentAdded,
      required this.onCommentDeleted});

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

  void _onCommentDeleted(int index) {
    setState(() {
      _comments.removeAt(index);
    });
    widget.onCommentDeleted();
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
          _comments = [];
          for (int i = 0; i < snapshot.data!.length; i++) {
            final comment = snapshot.data![i];
            _comments.add(
              CommentItem(
                username: comment.owner["username"],
                profilePictureUrl: comment.owner["profile_image"],
                comment: comment.content,
                timestamp: comment.elapsedTimeString,
                likes: comment.numberOfLikes,
                userId: comment.owner["_id"],
                commentId: comment.id,
                likesList: comment.likes,
                onCommentDeleted: () => _onCommentDeleted(i),
                user: comment.owner["_id"],
              ),
            );
          }
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
                        return CommentItem(
                          username: comment.username,
                          profilePictureUrl: comment.profilePictureUrl,
                          comment: comment.comment,
                          timestamp: comment.timestamp,
                          likes: comment.likes,
                          userId: comment.userId,
                          commentId: comment.commentId,
                          likesList: comment.likesList,
                          user: comment.user,
                          onCommentDeleted: () => _onCommentDeleted(index),
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
                                    userId: _prefs.getString('userId')!,
                                    commentId: newComment.id,
                                    likesList: newComment.likes,
                                    user: newComment.owner["_id"],
                                    onCommentDeleted: () =>
                                        _onCommentDeleted(0)),
                              );
                            });

                            _commentController.clear();
                            _scrollController.animateTo(
                              0.0,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );
                            widget.onCommentAdded();
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

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../viewmodel/profileViewModel.dart';
import '../../screens/Profile/profile.dart';
import 'commentDialog.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:ui' as ui;

class PostItem extends StatefulWidget {
  final String id;
  final String username;
  final String profilePhotoUrl;
  final String postDescription;
  final String postPhotoUrl;
  final int numLikes;
  int numComments;
  final DateTime createdAt;
  final bool isLiked;
  final List<String> likes;
  final bool isOwner;
  final VoidCallback onPostDeleted;
  final String? user;
  final Map<String, dynamic>? sharedFrom;
  final bool isSharedPost;
  final PostItem? childPost;
  final String? currentUserId;
  final FocusNode? focusNode;
  final bool openCommentDialog;
  final String? commentId;

  PostItem({
    super.key,
    required this.username,
    required this.profilePhotoUrl,
    required this.postDescription,
    required this.postPhotoUrl,
    required this.numLikes,
    required this.numComments,
    required this.createdAt,
    required this.id,
    required this.isLiked,
    required this.likes,
    required this.isOwner,
    required this.onPostDeleted,
    required this.user,
    required this.sharedFrom,
    required this.isSharedPost,
    required this.childPost,
    required this.currentUserId,
    this.focusNode,
    this.openCommentDialog = false,
    this.commentId,
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool? _isLiked;
  int? _numLikes;
  String? _userToken;
  bool _showMore = false;
  int? _totalLines;

  Future<void> _deletePost() async {
    try {
      await ProfileViewModel.deletePost(widget.id);
      widget.onPostDeleted(); // Call the callback function
    } catch (e) {
      // Handle error, e.g., show a snackbar with an error message
    }
  }

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    _numLikes = widget.numLikes;
    _getUserToken().then((token) {
      setState(() {
        _userToken = token;
        String userId = JwtDecoder.decode(token)['id'];
        _isLiked = widget.likes.contains(userId);
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateTotalLines();
      if (widget.openCommentDialog) {
        showCommentDialog(context);
      }
    });
  }

  void _calculateTotalLines() {
    final textSpan = TextSpan(
      text: widget.postDescription,
      style: const TextStyle(height: 1.5),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: ui.TextDirection.ltr,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 10);
    final totalLines = textPainter.computeLineMetrics().length;

    setState(() {
      _totalLines = totalLines;
    });
  }

  Future<String> _getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId') ?? '';
  }

  void showCommentDialog(BuildContext context) {
    GlobalKey<CommentDialogState> commentDialogKey =
        GlobalKey<CommentDialogState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CommentDialog(
            key: commentDialogKey,
            postId: widget.id,
            commentId: widget.commentId,
            onCommentAdded: () {
              setState(() {
                widget.numComments += 1;
              });
            },
            onCommentDeleted: () {
              setState(() {
                widget.numComments -= 1;
              });
            },
            focusNode: widget.focusNode,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final elapsedTimeString = timeago.format(widget.createdAt);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Stack(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(widget.profilePhotoUrl),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(
                              user: widget.user!,
                              isCurrentUser: false,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        widget.username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(elapsedTimeString,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              if (widget.isOwner) // Conditionally show the three-dot menu
                Positioned(
                  top: 5,
                  right: 5,
                  child: PopupMenuButton<int>(
                    icon: const Icon(Icons.more_vert,
                        color: Colors.grey), // Set the icon and its color here
                    onSelected: (value) async {
                      if (value == 1) {
                        await _deletePost(); // Call the delete function when the option is selected
                        // Optionally, you can remove the post from the UI using setState
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem(
                        value: 1,
                        child: Text('Delete post'),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (!widget.isSharedPost && widget.postDescription.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 15, 5, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.postDescription,
                    maxLines: _showMore ? null : 6,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(height: 1.5),
                  ),
                  if (_totalLines != null && _totalLines! > 6)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _showMore = !_showMore;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          _showMore ? "Show less" : "Show more",
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          if (!widget.isSharedPost) Image.network(widget.postPhotoUrl),
          if (widget.isSharedPost && widget.childPost != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.childPost,
            ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: GestureDetector(
              onTap: () async {
                final updatedPost =
                    await ProfileViewModel.likePost(widget.id, _userToken!);

                setState(() {
                  _isLiked = !_isLiked!;
                  _numLikes = updatedPost.numberOfLikes;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    _isLiked ?? false ? Icons.favorite : Icons.favorite_border,
                    color: _isLiked ?? false ? Colors.red : Colors.grey,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(_numLikes.toString()),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      showCommentDialog(context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.comment,
                          color: Colors.grey,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(widget.numComments.toString()),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      String userId =
                          await JwtDecoder.decode(_userToken!)['id'];
                      ProfileViewModel.sharePost(widget.id, userId, context);
                    },
                    child: const Icon(
                      Icons.share,
                      color: Colors.grey,
                      size: 24,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

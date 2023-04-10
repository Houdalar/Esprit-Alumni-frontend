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

  PostItem({
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
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool? _isLiked;
  int? _numLikes;
  String? _userToken;
  bool _showMore = false;
  GlobalKey _textKey = GlobalKey();
  int? _totalLines;

  int _getNumberOfLines() {
    final RenderBox textBox =
        _textKey.currentContext!.findRenderObject() as RenderBox;
    final double lineHeight = textBox.size.height / textBox.size.width;
    return (textBox.size.height / lineHeight).ceil();
  }

  Future<void> _deletePost() async {
    try {
      await ProfileViewModel.deletePost(widget.id);
      widget.onPostDeleted(); // Call the callback function
    } catch (e) {
      // Handle error, e.g., show a snackbar with an error message
    }
  }

  Widget _buildSharedPostItem(Map<String, dynamic> sharedFrom) {
    bool isChildPostLiked = sharedFrom['likes'] != null &&
        sharedFrom['likes'].contains(widget.currentUserId);
    return Material(
      elevation: 4.0, // Add more elevation to the shared post
      child: PostItem(
        username: widget.username,
        profilePhotoUrl: widget.profilePhotoUrl,
        postDescription: '',
        postPhotoUrl: '',
        numLikes: widget.numLikes,
        numComments: widget.numComments,
        createdAt: widget.createdAt,
        id: widget.id,
        isLiked: widget.isLiked,
        likes: widget.likes,
        isOwner: widget.isOwner,
        onPostDeleted: widget.onPostDeleted,
        user: widget.user,
        sharedFrom: null,
        isSharedPost: true,
        currentUserId: widget.currentUserId,
        childPost: PostItem(
          username: sharedFrom['username'] ?? '',
          profilePhotoUrl: sharedFrom['profile_image'] ?? '',
          postDescription: sharedFrom['postDescription'] ?? '',
          postPhotoUrl: sharedFrom['postPhotoUrl'] ?? '',
          numLikes: sharedFrom['numLikes'] ?? 0,
          numComments: sharedFrom['numComments'] ?? 0,
          createdAt: DateTime.parse(
              sharedFrom['createdAt'] ?? DateTime.now().toIso8601String()),
          id: sharedFrom['_id'] ?? '',
          isLiked: isChildPostLiked,
          likes: sharedFrom['likes'] != null
              ? List<String>.from(sharedFrom['likes'])
              : [],
          isOwner: false,
          onPostDeleted: () {}, // Handle the post deletion
          user: sharedFrom['_id'] ?? '',
          sharedFrom: null,
          isSharedPost: false,
          childPost: null,
          currentUserId: widget.currentUserId,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    _numLikes = widget.numLikes;
    _getUserToken().then((token) {
      print(JwtDecoder.decode(token)['id']);
      setState(() {
        _userToken = token;
        String userId = JwtDecoder.decode(token)['id'];
        _isLiked = widget.likes.contains(userId); // Use userId instead of token
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _calculateTotalLines();
    });
  }

  void _calculateTotalLines() {
    final textSpan = TextSpan(
      text: widget.postDescription,
      style: TextStyle(height: 1.5),
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

  @override
  Widget build(BuildContext context) {
    final elapsedTimeString = timeago.format(widget.createdAt);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Stack(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(widget.profilePhotoUrl),
                ),
                title: Container(
                  child: Column(
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
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(elapsedTimeString,
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              if (widget.isOwner) // Conditionally show the three-dot menu
                Positioned(
                  top: 5,
                  right: 5,
                  child: PopupMenuButton<int>(
                    icon: Icon(Icons.more_vert,
                        color: Colors.grey), // Set the icon and its color here
                    onSelected: (value) async {
                      if (value == 1) {
                        await _deletePost(); // Call the delete function when the option is selected
                        // Optionally, you can remove the post from the UI using setState
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
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
                    style: TextStyle(height: 1.5),
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
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          if (!widget.isSharedPost && widget.postPhotoUrl != null)
            Image.network(widget.postPhotoUrl),
          if (widget.isSharedPost && widget.childPost != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.childPost,
            ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                  SizedBox(
                    width: 8,
                  ),
                  Text(_numLikes.toString()),
                  SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: // set the height automatically
                                MediaQuery.of(context).size.height,
                            child: CommentDialog(
                              postId: widget.id,
                              onCommentAdded: () {
                                setState(() {
                                  // Update the number of comments, e.g., increment by 1
                                  widget.numComments += 1;
                                });
                              },
                              onCommentDeleted: () {
                                setState(() {
                                  widget.numComments -= 1;
                                });
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.comment,
                          color: Colors.grey,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(widget.numComments.toString()),
                      ],
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () async {
                      String userId =
                          await JwtDecoder.decode(_userToken!)['id'];
                      ProfileViewModel.sharePost(widget.id, userId!, context);
                    },
                    child: Icon(
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

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../viewmodel/profileViewModel.dart';
import 'commentDialog.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool? _isLiked;
  int? _numLikes;
  String? _userToken;

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
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(widget.profilePhotoUrl),
            ),
            title: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(elapsedTimeString,
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 15, 5, 20),
            child: Text(widget.postDescription),
          ),
          if (widget.postPhotoUrl != null) Image.network(widget.postPhotoUrl),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: GestureDetector(
              onTap: () async {
                print("Token: $_userToken");
                print("Post ID: ${widget.id}");
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
                  Icon(
                    Icons.share,
                    color: Colors.grey,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

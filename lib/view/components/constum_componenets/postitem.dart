import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'commentDialog.dart';

class PostItem extends StatelessWidget {
  final String username;
  final String profilePhotoUrl;
  final String postDescription;
  final String postPhotoUrl;
  final int numLikes;
  final int numComments;
  final DateTime createdAt;

  PostItem({
    required this.username,
    required this.profilePhotoUrl,
    required this.postDescription,
    required this.postPhotoUrl,
    required this.numLikes,
    required this.numComments,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final elapsedTimeString = timeago.format(createdAt);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(profilePhotoUrl),
            ),
            title: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
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
            child: Text(postDescription),
          ),
          if (postPhotoUrl != null) Image.network(postPhotoUrl),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.thumb_up,
                  color: Colors.grey,
                  size: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(numLikes.toString()),
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
                          child:
                              CommentDialog(postId: "640d1e006c7bd6cd759d691a"),
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
                      Text(numComments.toString()),
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
        ],
      ),
    );
  }
}

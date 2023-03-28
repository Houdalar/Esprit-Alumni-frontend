import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final String username;
  final String profilePictureUrl;
  final String comment;
  final String timestamp;
  final int likes;

  CommentItem({
    required this.username,
    required this.profilePictureUrl,
    required this.comment,
    required this.timestamp,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profilePictureUrl),
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
                            username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(comment,
                              style: TextStyle(fontSize: 16, height: 1.5)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    SizedBox(width: 8.0),
                    Icon(
                      Icons.favorite_border,
                      size: 18.0,
                    ),
                    SizedBox(width: 4.0),
                    Text(likes.toString(), style: TextStyle(fontSize: 15.5)),
                    SizedBox(width: 8.0),
                    Text(timestamp, style: TextStyle(color: Colors.grey)),
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

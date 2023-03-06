import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final String postImage;
  final String description;
  final int likesCount;
  final int commentsCount;
  final String ownerName;
  final String ownerProfileImage;

  const PostItem({
    Key? key,
    required this.postImage,
    required this.description,
    required this.likesCount,
    required this.commentsCount,
    required this.ownerName,
    required this.ownerProfileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(ownerProfileImage),
            ),
            title: Text(ownerName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description),
          ),
          Image.asset(postImage),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
            child: Row(
              children: [
                Icon(Icons.favorite_border, color: Colors.red, size: 30.0),
                SizedBox(width: 4.0),
                Text(likesCount.toString()),
                SizedBox(width: 25.0),
                Icon(Icons.comment_outlined,
                    color: AppColors.darkgray, size: 30.0),
                SizedBox(width: 4.0),
                Text(commentsCount.toString()),
                Spacer(),
                Icon(Icons.reply_rounded,
                    color: AppColors.darkgray, size: 30.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

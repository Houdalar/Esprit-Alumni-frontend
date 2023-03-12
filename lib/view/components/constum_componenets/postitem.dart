import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:flutter/material.dart';

/*class PostItem extends StatelessWidget {
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
                const Icon(Icons.favorite_border,
                    color: Colors.red, size: 30.0),
                const SizedBox(width: 4.0),
                Text(likesCount.toString()),
                const SizedBox(width: 25.0),
                const Icon(Icons.comment_outlined,
                    color: AppColors.darkgray, size: 30.0),
                const SizedBox(width: 4.0),
                Text(commentsCount.toString()),
                const Spacer(),
                const Icon(Icons.reply_rounded,
                    color: AppColors.darkgray, size: 30.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/

class PostItem extends StatelessWidget {
  final String username;
  final String profilePhotoUrl;
  final String postDescription;
  final String postPhotoUrl;
  final int numLikes;
  final int numComments;

  PostItem({
    required this.username,
    required this.profilePhotoUrl,
    required this.postDescription,
    required this.postPhotoUrl,
    required this.numLikes,
    required this.numComments,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(profilePhotoUrl),
            ),
            title: Text(username),
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
                Icon(
                  Icons.comment,
                  color: Colors.grey,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(numComments.toString()),
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

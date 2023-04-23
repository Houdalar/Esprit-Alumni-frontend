import 'package:flutter/material.dart';
import '../../screens/Profile/profile.dart';

class UserSearchResultItem extends StatelessWidget {
  final String username;
  final String profileImage;
  final String profileId;
  final String userId;

  const UserSearchResultItem(
      {super.key,
      required this.username,
      required this.profileImage,
      required this.profileId,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(
              user: userId,
              isCurrentUser: false,
            ),
          ),
        );
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(profileImage),
        ),
        title: Text(username),
      ),
    );
  }
}

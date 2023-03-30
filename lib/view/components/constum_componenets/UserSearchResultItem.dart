import 'package:flutter/material.dart';

class UserSearchResultItem extends StatelessWidget {
  final String username;
  final String profileImage;

  UserSearchResultItem({required this.username, required this.profileImage});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(profileImage),
      ),
      title: Text(username),
    );
  }
}

import 'package:esprit_alumni_frontend/viewmodel/userViewModel.dart';
import 'package:flutter/material.dart';
import '../../model/PostModel.dart';
import '../../viewmodel/profileViewModel.dart';
import '../components/constum_componenets/createPost.dart';
import '../components/constum_componenets/postitem.dart';
import '../components/constum_componenets/searchBar.dart';

class HomePage extends StatefulWidget {
  final String? username;
  final String? profilePic;
  final String? id;
  const HomePage(this.username, this.profilePic, this.id, {Key? key})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// the home page state
class _HomePageState extends State<HomePage> {
  final searchbar = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  // the home page state
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      left: true,
      right: true,
      child: Scaffold(
        body: FutureBuilder(
          future: ProfileViewModel.getHomepage(widget.id, context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final posts = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: posts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return CreatePost(
                      widget.profilePic,
                      widget.username,
                    );
                  } else {
                    final post = posts[index - 1];
                    return PostItem(
                      username: post.owner['username'],
                      profilePhotoUrl: post.owner['profile_image'],
                      postPhotoUrl: post.image,
                      postDescription: post.caption,
                      numLikes: post.numberOfLikes,
                      numComments: post.numberOfComments,
                      createdAt: post.createdAt,
                    );
                  }
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

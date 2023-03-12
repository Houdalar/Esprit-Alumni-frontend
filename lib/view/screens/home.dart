import 'package:flutter/material.dart';
import '../../model/PostModel.dart';
import '../../viewmodel/profileViewModel.dart';
import '../components/constum_componenets/createPost.dart';
import '../components/constum_componenets/postitem.dart';
import '../components/constum_componenets/searchBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
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
  /* Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // FacebookSearchBar(),
          FutureBuilder<List<PostModel>>(
            future: ProfileViewModel.getHomepage(
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MGJhYjk4YThlZGExNzE4MTNjNjRmMSIsImlhdCI6MTY3ODQ4NjYzOX0.N6rn19GJqYr2MB5sIsIXCJJJ7uKdxfz-FxhaPAe5AeA",
                context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final posts = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return PostItem(
                        username: post.owner['username'],
                        profilePhotoUrl: post.owner['profile_image'],
                        postPhotoUrl: post.image,
                        postDescription: post.caption,
                        numLikes: post.numberOfLikes,
                        numComments: post.numberOfComments,
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }*/

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProfileViewModel.getHomepage(
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MGJhYjk4YThlZGExNzE4MTNjNjRmMSIsImlhdCI6MTY3ODQ4NjYzOX0.N6rn19GJqYr2MB5sIsIXCJJJ7uKdxfz-FxhaPAe5AeA",
          context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final posts = snapshot.data!;
          return Scaffold(
            body: Column(
              children: [
                // FacebookSearchBar(),
                CreatePost(
                    "https://images.unsplash.com/photo-1617157362469-1b2e1b2e1b1c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"),
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return PostItem(
                        username: post.owner['username'],
                        profilePhotoUrl: post.owner['profile_image'],
                        postPhotoUrl: post.image,
                        postDescription: post.caption,
                        numLikes: post.numberOfLikes,
                        numComments: post.numberOfComments,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

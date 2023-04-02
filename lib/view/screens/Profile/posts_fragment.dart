import 'package:esprit_alumni_frontend/viewmodel/profileViewModel.dart';
import 'package:flutter/material.dart';

import '../../../model/PostModel.dart';
import '../../components/constum_componenets/postitem.dart';

class PostsFragment extends StatefulWidget {
  final String? id;
  const PostsFragment({Key? key, required this.id}) : super(key: key);

  @override
  State<PostsFragment> createState() => _PostsFragmentState();
}

class _PostsFragmentState extends State<PostsFragment> {
  Future<void> _refreshPosts() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProfileViewModel.getPosts(widget.id, context),
      builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
        if (snapshot.hasData) {
          final posts = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _refreshPosts,
            child: SingleChildScrollView(
              child: Column(
                children: posts.map((post) {
                  // Replace with the actual properties of your PostModel class
                  return PostItem(
                    id: post.id,
                    username: post.owner['username'],
                    profilePhotoUrl: post.owner['profile_image'],
                    postPhotoUrl: post.image,
                    postDescription: post.caption,
                    numLikes: post.numberOfLikes,
                    numComments: post.numberOfComments,
                    createdAt: post.createdAt,
                    isLiked: false,
                    likes: post.likes,
                    isOwner: true,
                    onPostDeleted: () {
                      setState(() {
                        // Remove the deleted post from the list
                        posts.remove(post);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

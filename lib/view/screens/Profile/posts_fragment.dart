import 'package:esprit_alumni_frontend/viewmodel/profileViewModel.dart';
import 'package:flutter/material.dart';

import '../../../model/PostModel.dart';
import '../../components/constum_componenets/postitem.dart';

class PostsFragment extends StatefulWidget {
  final String? id;
  final bool? isCurrentUser;
  final String? userId;
  const PostsFragment({Key? key, this.id, this.isCurrentUser, this.userId = ""})
      : super(key: key);

  @override
  State<PostsFragment> createState() => _PostsFragmentState();
}

class _PostsFragmentState extends State<PostsFragment> {
  Future<void> _refreshPosts() async {
    setState(() {});
  }

  PostItem? buildChildPost(Map<String, dynamic>? sharedFrom) {
    if (sharedFrom == null) {
      return null;
    }

    return PostItem(
      id: sharedFrom['_id'] ?? '',
      username: sharedFrom['username'] ?? '',
      profilePhotoUrl: sharedFrom['profile_image'] ?? '',
      postPhotoUrl: sharedFrom['postPhotoUrl'] ?? '',
      postDescription: sharedFrom['postDescription'] ?? '',
      numLikes: sharedFrom['numLikes'] ?? 0,
      numComments: sharedFrom['numComments'] ?? 0,
      createdAt: DateTime.parse(
          sharedFrom['createdAt'] ?? DateTime.now().toIso8601String()),
      isLiked: false,
      likes: [],
      isOwner: false,
      onPostDeleted: () {},
      user: sharedFrom['_id'] ?? '',
      sharedFrom: null,
      isSharedPost: false,
      currentUserId: widget.userId,
      childPost: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.isCurrentUser!
          ? ProfileViewModel.getPosts(widget.id, context)
          : ProfileViewModel.getUserPosts(widget.userId, context),
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
                    user: post.owner['_id'],
                    sharedFrom: post.sharedFrom,
                    isSharedPost: post.sharedFrom != null,
                    currentUserId: widget.userId,
                    childPost: buildChildPost(post.sharedFrom),
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

import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:flutter/material.dart';

import '../../../model/PostModel.dart';
import '../../../viewmodel/profileViewModel.dart';
import '../../components/constum_componenets/postitem.dart';

class SinglePostView extends StatefulWidget {
  final String postId;

  const SinglePostView({super.key, required this.postId});

  @override
  SinglePostViewState createState() => SinglePostViewState();
}

class SinglePostViewState extends State<SinglePostView> {
  PostModel? _post;

  @override
  void initState() {
    super.initState();
    _fetchPostData();
  }

  void _fetchPostData() async {
    try {
      PostModel post = await ProfileViewModel.getPostById(widget.postId);
      setState(() {
        _post = post;
      });
    } catch (e) {
      rethrow;
    }
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
      likes: const [],
      isOwner: false,
      onPostDeleted: () {},
      user: sharedFrom['_id'] ?? '',
      sharedFrom: null,
      isSharedPost: false,
      currentUserId: _post!.owner['_id'],
      childPost: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_post == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: AppColors.primary,
          ),
        ),
        body: SingleChildScrollView(
          child: PostItem(
            id: _post!.id,
            username: _post!.owner['username'],
            profilePhotoUrl: _post!.owner['profile_image'],
            postDescription: _post!.caption,
            postPhotoUrl: _post!.image,
            numLikes: _post!.numberOfLikes,
            numComments: _post!.numberOfComments,
            createdAt: _post!.createdAt,
            isLiked: _post!.likes.contains(_post!.owner['_id']),
            likes: _post!.likes,
            isOwner: false,
            onPostDeleted: () {
              Navigator.of(context).pop();
            },
            user: _post!.owner['_id'],
            sharedFrom: _post!.sharedFrom,
            isSharedPost: _post!.sharedFrom != null,
            childPost: buildChildPost(_post!.sharedFrom),
            currentUserId: _post!.owner['_id'], // Pass the current user id
          ),
        ),
      );
    }
  }
}

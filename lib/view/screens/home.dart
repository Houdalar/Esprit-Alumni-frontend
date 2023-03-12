import 'package:esprit_alumni_frontend/viewmodel/userViewModel.dart';
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
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MGJhYjk4YThlZGExNzE4MTNjNjRmMSIsImlhdCI6MTY3ODQ4NjYzOX0.N6rn19GJqYr2MB5sIsIXCJJJ7uKdxfz-FxhaPAe5AeA";

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
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: ProfileViewModel.getHomepage(token, context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final posts = snapshot.data!;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            FutureBuilder(
                              future: UserViewModel.getUser(token, context),
                              builder: (context, snapshot) =>
                                  snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? const CreatePost("")
                                      : snapshot.hasError
                                          ? Text('Error: ${snapshot.error}')
                                          : CreatePost(
                                              snapshot.data!['profile_image']),
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
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
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

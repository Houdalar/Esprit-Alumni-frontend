import 'package:esprit_alumni_frontend/viewmodel/userViewModel.dart';
import 'package:flutter/material.dart';
import '../../model/PostModel.dart';
import '../../model/serchUser.dart';
import '../../model/usermodel.dart';
import '../../viewmodel/profileViewModel.dart';
import '../components/constum_componenets/UserSearchResultItem.dart';
import '../components/constum_componenets/createPost.dart';
import '../components/constum_componenets/postitem.dart';
import '../components/constum_componenets/searchBar.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class HomePage extends StatefulWidget {
  final String? username;
  final String? profilePic;
  final String? id;
  const HomePage(this.username, this.profilePic, this.id, {Key? key})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchActive = false;
  List<SearchUser> _searchResults = [];
  final _searchSubject = BehaviorSubject<String>();

  Future<void> _refreshHomePage() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);

    _searchSubject.stream
        .debounceTime(Duration(milliseconds: 500))
        .listen((query) async {
      if (query.isNotEmpty) {
        final users = await UserViewModel.searchUsers(query);
        setState(() {
          _searchResults = users;
          _isSearchActive = true;
        });
      } else {
        setState(() {
          _searchResults = [];
          _isSearchActive = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchSubject.close();
    super.dispose();
  }

  void _onSearchChanged() {
    _searchSubject.add(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search users...',
                    fillColor:
                        Colors.grey[200], // Set the grey background color
                    filled: true,
                    contentPadding: EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          BorderSide.none, // Remove the border when focused
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                    ),
                  ),
                  onChanged: (value) async {
                    if (value.isNotEmpty) {
                      final users = await UserViewModel.searchUsers(value);
                      setState(() {
                        _searchResults = users;
                        _isSearchActive = true;
                      });
                    } else {
                      setState(() {
                        _searchResults = [];
                        _isSearchActive = false;
                      });
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: _isSearchActive
                  ? ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final user = _searchResults[index];
                        return UserSearchResultItem(
                          username: user.username,
                          profileImage: user.profileImage,
                        );
                      },
                    )
                  : RefreshIndicator(
                      onRefresh:
                          _refreshHomePage, // Add the _refreshHomePage method here
                      child: FutureBuilder(
                        future:
                            ProfileViewModel.getHomepage(widget.id, context),
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
                                    id: post.id,
                                    username: post.owner['username'],
                                    profilePhotoUrl:
                                        post.owner['profile_image'],
                                    postPhotoUrl: post.image,
                                    postDescription: post.caption,
                                    numLikes: post.numberOfLikes,
                                    numComments: post.numberOfComments,
                                    createdAt: post.createdAt,
                                    isLiked: false,
                                    likes: post.likes,
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
            ),
          ],
        ),
      ),
    );
  }
}

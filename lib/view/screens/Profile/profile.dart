import 'dart:convert';
import 'dart:io';

import 'package:esprit_alumni_frontend/view/screens/settings/settings.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:esprit_alumni_frontend/view/components/themes/profile_clipper.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/career_fragment.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/posts_fragment.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/settings_popup.dart';
import 'package:esprit_alumni_frontend/viewmodel/profileViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';

import '../../../model/profilemodel.dart';
import '../../../model/serchUser.dart';
import '../../components/constum_componenets/UserSearchResultItem.dart';

class Profile extends StatefulWidget {
  final String id;
  final bool isCurrentUser;
  final String user;
  const Profile(
      {this.isCurrentUser = true, Key? key, this.id = "", this.user = ""})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  // For the posts and career
  late final TabController _tabController;
  late SharedPreferences _prefs;
  String? token = "";
  String? userId;
  int _numberOfFollowers = 0;
  bool isFollowing = false;
  List<String> followerIds = [];

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      token = _prefs.getString('userId') ?? "";
      userId = JwtDecoder.decode(token!)['id'];
    });

    if (userId!.isNotEmpty) {
      List<SearchUser> followers = await ProfileViewModel.getFollowers(token!);
      followerIds = followers.map((follower) => follower.userId).toList();
      setState(() {
        isFollowing = followerIds.contains(widget.user);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializePrefs();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final picker = ImagePicker();

  void _showFollowersDialog() async {
    List<SearchUser> followers = widget.isCurrentUser
        ? await ProfileViewModel.getFollowers(userId!)
        : await ProfileViewModel.getFollowers(widget.user);
    await ProfileViewModel.getFollowers(userId!);
    followerIds = followers.map((follower) => follower.userId).toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Followers"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: followers.length,
              itemBuilder: (BuildContext context, int index) {
                return UserSearchResultItem(
                  username: followers[index].username,
                  profileImage: followers[index].profileImage,
                  profileId: followers[index].profileId,
                  userId: followers[index].userId,
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showFolloingDialog() async {
    List<SearchUser> followers = widget.isCurrentUser
        ? await ProfileViewModel.getFollowing(userId!)
        : await ProfileViewModel.getFollowing(widget.user);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Followers"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: followers.length,
              itemBuilder: (BuildContext context, int index) {
                return UserSearchResultItem(
                  username: followers[index].username,
                  profileImage: followers[index].profileImage,
                  profileId: followers[index].profileId,
                  userId: followers[index].userId,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> uploadPic(
      BuildContext context, String token, File imageFile) async {
    String apiUrl = 'http://10.0.2.2:8081/updateProfileImage/$token';

    var request = http.MultipartRequest('PUT', Uri.parse(apiUrl))
      ..files.add(
          await http.MultipartFile.fromPath('profile_image', imageFile.path));

    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      var profile = ProfileModel.fromJson(json.decode(response.body));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Profile picture uploaded'),
        backgroundColor: Colors.grey,
      ));
      ProfileViewModel.fetchProfile(token);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error uploading profile picture'),
        backgroundColor: Colors.grey,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.red,
      systemNavigationBarColor: Colors.white,
    ));
    return FutureBuilder<ProfileModel>(
      future: widget.isCurrentUser
          ? ProfileViewModel.fetchProfile(token!)
          : ProfileViewModel.getProfile(widget.user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error loading profile: ${snapshot.error}'));
        } else {
          final profile = snapshot.data!;
          _numberOfFollowers = profile.numberOfFollowers;
          // Use the profile data to build the UI of the Profile widget
          return Scaffold(
              body: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              // background image
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ClipPath(
                    clipper: ProfileClipper(),
                    child: const Image(
                      width: double.infinity,
                      image: AssetImage('media/background_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 60.0,
                    right: 5.0,
                    child: widget.isCurrentUser
                        ? IconButton(
                            icon: const Icon(Icons.settings),
                            iconSize: 27.0,
                            color: AppColors.primaryDark,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const Settings();
                                },
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                  Positioned(
                      top: 110.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            )
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (widget.isCurrentUser) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          GestureDetector(
                                            child: const Text('Show Image'),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        content: SizedBox(
                                                          width:
                                                              double.maxFinite,
                                                          child: Image.network(
                                                            profile
                                                                .profileImage,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ));
                                                  });
                                            },
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(8.0)),
                                          GestureDetector(
                                            child: const Text('Edit Image'),
                                            onTap: () async {
                                              final pickedFile =
                                                  await picker.getImage(
                                                      source:
                                                          ImageSource.gallery);
                                              // Use the pickedFile variable to access the selected image
                                              await uploadPic(context, token!,
                                                  File(pickedFile!.path));
                                              Navigator.of(context).pop();
                                              // display the image
                                              setState(() {
                                                ProfileViewModel.fetchProfile(
                                                    token!);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: ClipOval(
                            child: Image.network(
                              profile.profileImage,
                              fit: BoxFit.cover,
                              width: 105.0,
                              height: 105.0,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return const Image(
                                  image: AssetImage('media/profile_image.png'),
                                  fit: BoxFit.cover,
                                  width: 105.0,
                                  height: 105.0,
                                );
                              },
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ))
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(children: <Widget>[
                        GestureDetector(
                          onTap: _showFolloingDialog,
                          child: Column(children: <Widget>[
                            Text(
                              profile.numberOfFollowing.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'Mukta Malar',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            const Text(
                              "Followings",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14.0,
                                fontFamily: 'Mukta Malar',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ]),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Text(profile.owner["username"],
                            style: const TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Mukta Malar',
                              letterSpacing: 1.5,
                              color: AppColors.primaryDark,
                            )),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.black,
                              size: 17.0,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              profile.location,
                              style: const TextStyle(
                                color: Color.fromARGB(136, 0, 0, 0),
                                fontSize: 16.0,
                                fontFamily: 'Mukta Malar',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ]),
                      Column(children: <Widget>[
                        GestureDetector(
                          onTap: _showFollowersDialog,
                          child: Column(children: <Widget>[
                            Text(
                              _numberOfFollowers.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'Mukta Malar',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            const Text(
                              "Followers",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14.0,
                                fontFamily: 'Mukta Malar',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ]),
                        ),
                      ])
                    ],
                  )),
              const SizedBox(height: 25.0),
              if (!widget.isCurrentUser)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                          ),
                          onPressed: () {
                            // Handle send message action
                          },
                          icon: const Icon(Icons.send,
                              color: AppColors.primaryDark),
                          label: const Text(
                            'Message',
                            style: TextStyle(color: AppColors.primaryDark),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30.0),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                          ),
                          onPressed: () async {
                            bool isFollowing =
                                await ProfileViewModel.followUser(
                                    token!, widget.user);
                            if (isFollowing) {
                              setState(() {
                                _numberOfFollowers =
                                    profile.numberOfFollowers + 1;
                                isFollowing = true;
                              });
                            } else {
                              setState(() {
                                _numberOfFollowers =
                                    profile.numberOfFollowers - 1;
                                isFollowing = false;
                              });
                            }
                          },
                          icon: isFollowing
                              ? const Icon(Icons.person_remove_alt_1,
                                  color: AppColors.primaryDark)
                              : const Icon(Icons.person_add_alt_1,
                                  color: AppColors.primaryDark),
                          label: Text(
                            isFollowing ? 'Unfollow' : 'Follow',
                            style:
                                const TextStyle(color: AppColors.primaryDark),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 15.0),

              // POSTS AND CAREER TABS ----------------------------------------------
              TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                indicatorColor: AppColors.primary,
                indicatorWeight: 2.0,
                labelStyle: const TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Mukta Malar',
                  fontWeight: FontWeight.w600,
                ),
                tabs: const <Widget>[
                  Tab(text: 'Career'),
                  Tab(text: 'Posts'),
                ],
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      CareerFragment(
                        profile.summary,
                        profile.status,
                        profile.education,
                        profile.skills,
                        widget.isCurrentUser,
                      ),
                      PostsFragment(
                        id: token!,
                        isCurrentUser: widget.isCurrentUser,
                        userId: widget.user,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )));
        }
      },
    );
  }
}

import 'dart:convert';
import 'dart:io';

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
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

//final token ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MjJmNjM4ZTcyMDhmOGU1NjYwOTI1OCIsImlhdCI6MTY4MDEwMDM5NX0.rSybSVHG-A4X2j3guWv3aXgLFafBaSrFZQdapc7LBpU";

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  // For the posts and career
  late final TabController _tabController;
  late SharedPreferences _prefs;
  String? token = "";
  String? userId;

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      token = _prefs.getString('userId') ?? "";
      userId = JwtDecoder.decode(token!)['id'];
    });
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
    List<SearchUser> followers = await ProfileViewModel.getFollowers(userId!);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Followers"),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: followers.length,
              itemBuilder: (BuildContext context, int index) {
                return UserSearchResultItem(
                  username: followers[index].username,
                  profileImage: followers[index].profileImage,
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showFolloingDialog() async {
    List<SearchUser> followers = await ProfileViewModel.getFollowing(userId!);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Followers"),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: followers.length,
              itemBuilder: (BuildContext context, int index) {
                return UserSearchResultItem(
                  username: followers[index].username,
                  profileImage: followers[index].profileImage,
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Profile picture uploaded'),
        backgroundColor: Colors.grey,
      ));
      ProfileViewModel.fetchProfile(token);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
      future: ProfileViewModel.fetchProfile(token!),
      builder: (context, snapshot) {
        print(snapshot.data);
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
                    child: Image(
                      width: double.infinity,
                      image: AssetImage('media/background_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 60.0,
                    right: 5.0,
                    child: IconButton(
                      icon: Icon(Icons.settings),
                      iconSize: 27.0,
                      color: AppColors.primaryDark,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SettingsPopup();
                          },
                        );
                      },
                    ),
                  ),
                  Positioned(
                      top: 110.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            )
                          ],
                        ),
                        child: Container(
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Text('Show Image'),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        content: Container(
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
                                          Padding(padding: EdgeInsets.all(8.0)),
                                          GestureDetector(
                                            child: Text('Edit Image'),
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
                            },
                            child: ClipOval(
                              child: Image.network(
                                //"http://172.16.11.227:8081/img/pdp.PNG1678107749613.png",
                                profile.profileImage,
                                fit: BoxFit.cover,
                                width: 105.0,
                                height: 105.0,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  // Return a placeholder or error image if the image fails to load
                                  return //Icon(Icons.error);
                                      Image(
                                    image:
                                        AssetImage('media/profile_image.png'),
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
                                  // Show a progress indicator while the image is loading
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(children: <Widget>[
                        GestureDetector(
                          onTap: _showFolloingDialog,
                          child: Column(children: <Widget>[
                            Text(
                              profile.numberOfFollowing.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'Mukta Malar',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
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
                            style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Mukta Malar',
                              letterSpacing: 1.5,
                              color: AppColors.primaryDark,
                            )),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.black,
                              size: 17.0,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              profile.location,
                              style: TextStyle(
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
                              profile.numberOfFollowers.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'Mukta Malar',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
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
              SizedBox(height: 25.0),

              // POSTS AND CAREER TABS ----------------------------------------------
              TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                indicatorColor: AppColors.primary,
                indicatorWeight: 2.0,
                labelStyle: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Mukta Malar',
                  fontWeight: FontWeight.w600,
                ),
                tabs: const <Widget>[
                  Tab(text: 'Career'),
                  Tab(text: 'Posts'),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
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
                      ),
                      PostsFragment(id: token!),
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

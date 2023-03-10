import 'dart:convert';

import 'package:esprit_alumni_frontend/view/components/themes/profile_clipper.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/career_fragment.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/posts_fragment.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/settings_popup.dart';
import 'package:esprit_alumni_frontend/viewmodel/profileViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:http/http.dart' as http;
import 'package:esprit_alumni_frontend/model/profile.dart';

/*class Profile extends StatelessWidget {
  const Profile({Key? key, required this.profile}) : super(key: key);
  final token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MDQ5YjU4YjViMDJiOGUyZDJjMTc1NSIsImlhdCI6MTY3ODAyMzU0M30.Q1EXmfgi5cOF-3YN4ux9Xe1dAHoaWiNNX9-3varOjZc";
  final ProfileModel profile;
*/

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  // For the posts and career
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MDVlMjE4OWI3MTgzODNiYTZlMWJiZiIsImlhdCI6MTY3ODEwNzIyMn0._PZVkfoErOlRj8G5RqSe3nAkh1YkJBHev8drD_8aI5A";
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.red,
      systemNavigationBarColor: Colors.white,
    ));
    return FutureBuilder<ProfileModel>(
      future: ProfileViewModel.fetchProfile(token),
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
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ClipPath(
                    clipper: ProfileClipper(),
                    child: Image(
                      width: double.infinity,
                      image: AssetImage('Assets/images/background_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 15.0,
                    right: 15.0,
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
                                return Icon(Icons.error);
                                /*Image(
                                  image: AssetImage(
                                      'Assets/images/profile_image.png'),
                                  fit: BoxFit.cover,
                                  width: 105.0,
                                  height: 105.0,
                                );*/
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
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(children: <Widget>[
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
                          "Following",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14.0,
                            fontFamily: 'Mukta Malar',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Text(profile.username,
                            style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Mukta Malar',
                              letterSpacing: 1.5,
                              color: AppColors.primaryDark,
                            )),
                        SizedBox(height: 10.0),
                        Text(
                          profile.location,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15.0,
                            fontFamily: 'Mukta Malar',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                      Column(children: <Widget>[
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
                      ])
                    ],
                  )),
              SizedBox(height: 25.0),
              /////////////// Posts and Career ///////////////
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
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    CareerFragment(profile.summary, profile.status),
                    PostsFragment(),
                  ],
                ),
              ),
            ],
          )));
        }
      },
    );
  }
}

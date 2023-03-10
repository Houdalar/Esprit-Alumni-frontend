import 'package:esprit_alumni_frontend/view/screens/Profile/home.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/nav_bottom.dart';
import 'package:esprit_alumni_frontend/view/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../view/components/themes/colors.dart';
import '../view/screens/rsetpassword2.dart';
import '../../model/profile.dart';

class ProfileViewModel extends ChangeNotifier {
  //final BuildContext context;
  static String baseUrl = "10.0.2.2:8081";
  ProfileViewModel();

  static Future<ProfileModel> fetchProfile(String token) async {
    final response = await http.get(Uri.http(baseUrl, "/getPortfolio/$token"));

    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      print(jsonMap);
      if (jsonMap != null) {
        /*ProfileModel profile = ProfileModel(
            owner: jsonMap["owner"],
            username: jsonMap["username"],
            location: jsonMap["location"],
            summary: jsonMap["summary"],
            education: [],
            status: jsonMap["status"],
            experience: [],
            skills: [],
            profileImage: jsonMap["profile_image"],
            following: [],
            followers: [],
            numberOfFollowers: jsonMap["number_of_followers"],
            numberOfFollowing: jsonMap["number_of_following"],
            posts: []);
        return (profile);*/
        return ProfileModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to parse profile data');
      }
    } else {
      throw Exception('Failed to load profile: ${response.statusCode}');
    }
  }

  /*static Future<bool> GetPortfolio(String? token, BuildContext context) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    http
        .post(Uri.http(baseUrl, "/getPortfolio/{$token}"), headers: headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        var profile = json.decode(response.body);
        print(profile);
        ProfileModel newProfile = ProfileModel (owner:profile.owner, location: profile.location, summary: profile.summary, education: profile.education, experience: profile.experience, skills: profile.skills, languages: profile.languages, interests: profile.interests, references: profile.references, projects: profile.projects, awards: profile.awards, certifications: profile.certifications, publications: profile.publications, courses: profile.courses, volunteer: profile.volunteer, testScores: profile.testScores, social: profile.social, website: profile.website, contact: profile.contact,);
        // Shared preferences
        //SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString("token", token);

      } else if (response.statusCode == 400) {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                  title: Text("Sign in failed",
                      style: TextStyle(color: AppColors.primary)),
                  content: Text("Wrong password"));
            });
      } else if (response.statusCode == 402) {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                  title: Text("Sign in failed",
                      style: TextStyle(color: AppColors.primary)),
                  content: Text(
                      "Your Email has not been verified. Please check your mail"));
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                  title: Text("Sign in failed",
                      style: TextStyle(color: AppColors.primary)),
                  content: Text(
                      "The email address is not associated with any account. please check and try again!"));
            });
      }
    });
  }*/
}

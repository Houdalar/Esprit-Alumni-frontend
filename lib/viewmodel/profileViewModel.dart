import 'dart:async';

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
import '../../model/PostModel.dart';

class ProfileViewModel extends ChangeNotifier {
  //final BuildContext context;
  static String baseUrl = "10.0.2.2:8081";
  ProfileViewModel();

  static Future<List<PostModel>> getHomepage(
      String? token, BuildContext context) {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    return http
        .get(Uri.http(baseUrl, "/getFollowingPosts/$token"), headers: headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => PostModel.fromJson(json)).toList();
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: const Text("Network error",
                      style: TextStyle(color: AppColors.primary)),
                  content: Container(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'media/No connection-bro.png',
                        height: 300,
                        width: 300,
                      ),
                      const Text(
                          "please check your internet connection and try again!"),
                    ],
                  )));
            });
        throw Exception('Failed to load data!');
      }
    });
  }
}

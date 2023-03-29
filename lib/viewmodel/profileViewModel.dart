import 'dart:async';
import 'dart:io';

import 'package:esprit_alumni_frontend/view/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../view/components/themes/colors.dart';
import '../model/commentModel.dart';
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

  static Future<void> createPost(String? token, String? description,
      String? category, File? image, BuildContext context) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    var request =
        http.MultipartRequest('POST', Uri.http(baseUrl, "/createPost"));
    request.fields['token'] = token!;
    request.fields['caption'] = description!;
    request.fields['category'] = category!;
    request.files.add(await http.MultipartFile.fromPath('image', image!.path));
    request.headers.addAll(headers);
    var res = await request.send();
    if (res.statusCode == 201) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: const Text("Done",
                    style: TextStyle(color: AppColors.primary)),
                content: Container(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'media/Ok-bro.png',
                      height: 300,
                      width: 300,
                    ),
                    const Text("Your post has been created successfully!"),
                  ],
                )));
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
                title: Text("Network error",
                    style: TextStyle(color: AppColors.primary)),
                content: Text(
                    "please check your internet connection and try again!"));
          });
    }
  }

  static Future<List<CommentModel>> getComments(String? postId) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    return http
        .get(Uri.http(baseUrl, "/getComments/$postId"), headers: headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => CommentModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load comments!');
      }
    });
  }

  static Future<CommentModel?> addComment(String? token, String? postId,
      String? content, BuildContext context) async {
    Map<String, dynamic> userData = {
      "token": token,
      "postId": postId,
      "content": content
    };

    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    try {
      final response = await http.post(
        Uri.http(baseUrl, "/addComment"),
        body: json.encode(userData),
        headers: headers,
      );

      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return CommentModel.fromJson(jsonData);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text(
                "failed",
                style: TextStyle(color: AppColors.primary),
              ),
              content: Text("Something went wrong, please try again later!"),
            );
          },
        );
        return null;
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Error",
              style: TextStyle(color: AppColors.primary),
            ),
            content: Text(
              "An error occurred while adding the comment. Please check your internet connection and try again.",
            ),
          );
        },
      );
      return null;
    }
  }

  static Future<PostModel> likePost(String postId, String token) async {
    final response = await http.post(
      Uri.http(baseUrl, '/likePost'),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode({'id': postId, 'token': token}),
    );

    if (response.statusCode == 200) {
      return PostModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to like the post');
    }
  }

  static Future<CommentModel?> likeComment(
    String userId,
    String commentId,
    BuildContext context,
  ) async {
    final response = await http.patch(
      Uri.http(baseUrl, '/likeComment'), // Replace with your API URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': userId, 'commentId': commentId}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return CommentModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to like the comment');
      return null;
    }
  }
}

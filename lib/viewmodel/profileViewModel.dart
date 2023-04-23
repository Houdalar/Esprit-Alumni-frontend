import 'dart:async';
import 'dart:io';
import 'package:esprit_alumni_frontend/model/notification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../view/components/themes/colors.dart';
import '../model/commentModel.dart';
import '../model/profilemodel.dart';
import '../model/serchUser.dart';
import '../../model/PostModel.dart';

class ProfileViewModel extends ChangeNotifier {
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
                  content: Column(
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
                  ));
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
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'media/Ok-bro.png',
                      height: 300,
                      width: 300,
                    ),
                    const Text("Your post has been created successfully!"),
                  ],
                ));
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
          return const AlertDialog(
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
    }
  }

  static Future<bool> deleteComment(
      String token, String commentId, BuildContext context) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map<String, dynamic> userData = {
      "token": token,
      "commentId": commentId,
    };
    return await http
        .put(Uri.http(baseUrl, "/deleteComment"),
            headers: headers, body: json.encode(userData))
        .then((http.Response response) {
      if (response.statusCode == 200) {
        return true;
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
        return false;
      }
    });
  }

  static Future<ProfileModel> fetchProfile(String token) async {
    final response = await http.get(Uri.http(baseUrl, "/getPortfolio/$token"));
    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      if (jsonMap != null) {
        return ProfileModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to parse profile data');
      }
    } else {
      throw Exception('Failed to load profile: ${response.statusCode}');
    }
  }

  static Future<ProfileModel> getProfile(String token) async {
    final response = await http.get(Uri.http(baseUrl, "/getProfile/$token"));
    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      if (jsonMap != null) {
        return ProfileModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to parse profile data');
      }
    } else {
      throw Exception('Failed to load profile: ${response.statusCode}');
    }
  }

  static Future<List<PostModel>> getPosts(String? token, BuildContext context) {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    return http
        .get(Uri.http(baseUrl, "/getPosts/$token"), headers: headers)
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
                  content: Column(
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
                  ));
            });
        throw Exception('Failed to load data!');
      }
    });
  }

  static Future<List<SearchUser>> getFollowers(String token) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    return http
        .get(Uri.parse('http://$baseUrl/getFollowers/$token'), headers: headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<SearchUser> followers = jsonData
            .map<SearchUser>(
                (followerJson) => SearchUser.fromJson(followerJson))
            .toList();
        return followers;
      } else {
        throw Exception('Failed to load followers');
      }
    });
  }

  static Future<List<SearchUser>> getFollowing(String token) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    return http
        .get(Uri.parse('http://$baseUrl/getFollowing/$token'), headers: headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<SearchUser> followers = jsonData
            .map<SearchUser>(
                (followerJson) => SearchUser.fromJson(followerJson))
            .toList();
        return followers;
      } else {
        throw Exception('Failed to load followers');
      }
    });
  }

  static Future<bool> deletePost(String id) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    return http
        .delete(Uri.parse('http://$baseUrl/deletePost/$id'), headers: headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to load followers');
      }
    });
  }

  static Future<ProfileModel> updateSummary(
      String token, String newSummary) async {
    final response = await http.put(
      Uri.http(baseUrl, "/editSummary/$token"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'summary': newSummary}),
    );
    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      final profile = ProfileModel.fromJson(jsonMap);
      if (jsonMap != null) {
        return profile;
      } else {
        throw Exception('Failed to parse profile data');
      }
    } else {
      throw Exception('Failed to update summary');
    }
  }

  static Future<ProfileModel> updateStatus(
      String token, String newStatus) async {
    final response = await http.put(
      Uri.http(baseUrl, "/editStatus/$token"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': newStatus}),
    );
    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      final profile = ProfileModel.fromJson(jsonMap);
      if (jsonMap != null) {
        return profile;
      } else {
        throw Exception('Failed to parse profile data');
      }
    } else {
      throw Exception('Failed to update summary');
    }
  }

  static Future<ProfileModel> updateSkills(
      String token, String newSkills) async {
    final response = await http.put(
      Uri.http(baseUrl, "/addSkills/$token"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'skills': newSkills}),
    );
    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      final profile = ProfileModel.fromJson(jsonMap);
      if (jsonMap != null) {
        return profile;
      } else {
        throw Exception('Failed to parse profile data');
      }
    } else {
      throw Exception('Failed to update summary');
    }
  }

  static Future<ProfileModel> updateEducation(
      String token, String newEducation) async {
    final response = await http.put(
      Uri.http(baseUrl, "/editEducation/$token"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'education': newEducation}),
    );
    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      final profile = ProfileModel.fromJson(jsonMap);
      if (jsonMap != null) {
        return profile;
      } else {
        throw Exception('Failed to parse profile data');
      }
    } else {
      throw Exception('Failed to update education');
    }
  }

  static Future<List<PostModel>> getUserPosts(
      String? id, BuildContext context) {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    return http
        .get(Uri.http(baseUrl, "/getUserPosts/$id"), headers: headers)
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
                  content: Column(
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
                  ));
            });
        throw Exception('Failed to load data!');
      }
    });
  }

  static Future<void> sharePost(
      String? postId, String? userId, BuildContext context) async {
    Map<String, dynamic> userData = {"postId": postId, "userId": userId};

    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    try {
      final response = await http.post(
        Uri.http(baseUrl, "/sharePost"),
        body: json.encode(userData),
        headers: headers,
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text(
                "done",
                style: TextStyle(color: AppColors.primary),
              ),
              content: Text("Post shared successfully!"),
            );
          },
        );
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
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
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
    }
  }

  static Future<bool> followUser(String token, String id) async {
    final String url = "http://$baseUrl/follow";

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'token': token,
        'id': id,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to follow user');
    }

    final responseBody = json.decode(response.body);
    return responseBody['isFollowed'];
  }

  static Future<List<NotificationModel>> getNotification(
      String? token, BuildContext context) {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    return http
        .get(Uri.http(baseUrl, "/getUserNotifications/$token"),
            headers: headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: const Text("Network error",
                      style: TextStyle(color: AppColors.primary)),
                  content: Column(
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
                  ));
            });
        throw Exception('Failed to load data!');
      }
    });
  }

  static Future<int> getNonReadNotificationsCount(String token) {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    return http
        .get(Uri.http(baseUrl, "/getUserUnreadNotificationsCount/$token"),
            headers: headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['count'];
      } else {
        throw Exception('Failed to load data!');
      }
    });
  }

  static Future<bool> markAllNotificationsAsRead(String token) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    final response = await http.put(
      Uri.http(baseUrl, "/markAllNotificationsAsRead/$token"),
      headers: headers,
    );

    if (response.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> markNotificationAsRead(
      String token, String notificationId) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    final response = await http.put(
      Uri.http(baseUrl, "/markNotificationAsRead/$token/$notificationId"),
      headers: headers,
    );
    if (response.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }

  static Future<PostModel> getPostById(String postId) async {
    final String url = "http://$baseUrl/getPostById/$postId";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get post');
    }

    final responseBody = json.decode(response.body);
    return PostModel.fromJson(responseBody);
  }
}

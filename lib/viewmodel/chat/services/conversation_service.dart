import 'dart:convert';
import 'dart:developer';
import 'package:esprit_alumni_frontend/app_constants.dart';
import 'package:esprit_alumni_frontend/model/message.dart';
import 'package:esprit_alumni_frontend/model/serchUser.dart';
import 'package:http/http.dart' as http;

class ConversationService {
  static String baseUrl = "10.0.2.2:8081";
  static const String url = AppConstants.baseUrl;

  static Future<List<MessageModel>> getConversationMessages(
      String sourceId, String targetId) async {
    final response = await http.post(
        Uri.parse('$url/chats/getConversationMessages'),
        body: json.encode({'sourceId': sourceId, 'targetId': targetId}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    log(response.body);
    if (response.statusCode == 200) {
      log(response.body);
      return (json.decode(response.body) as List)
          .map((data) => MessageModel.fromJson(data))
          .toList();
    } else {
      log(response.body);
      throw Exception('Failed to load messages');
    }
  }

  static Future<void> deleteMessage(messageId) async {
    final response = await http.delete(Uri.parse('$url/chats/deleteMessage'),
        body: json.encode({'messageId': messageId}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      log(response.body);
    } else {
      throw Exception('Failed to delete message');
    }
  }

  static Future<List<SearchUser>> searchUsers(String query) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    return http
        .get(Uri.parse('http://$baseUrl/search?search=$query'),
            headers: headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<SearchUser> users = jsonData
            .map<SearchUser>((userJson) => SearchUser.fromJson(userJson))
            .toList();
        return users;
      } else {
        throw Exception('Failed to load users');
      }
    });
  }

  // static Future<ConversationModel> getConversation(String targetId) async {
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json; charset=UTF-8"
  //   };
  //   return http
  //       .post(Uri.parse("http://172.16.5.42:3000/chats/getConversation"),
  //           body: json.encode({'targetId': targetId}), headers: headers)
  //       .then((http.Response response) async {
  //     if (response.statusCode == 200) {
  //       return ConversationModel.fromJson(json.decode(response.body));
  //     } else {
  //       throw Exception('Failed to load conversation');
  //     }
  //   });
  // }
}

import 'dart:convert';
import 'dart:developer';
import 'package:esprit_alumni_frontend/app_constants.dart';
import 'package:esprit_alumni_frontend/model/conversation.dart';
import 'package:http/http.dart' as http;

class MessagesService {
  static const String baseUrl = AppConstants.baseUrl;

  static Future<List<ConversationModel>> getUserConversations(
      String userId) async {
    const url = "$baseUrl/chats/getUserConversations";
    final response = await http.post(Uri.parse(url),
        body: json.encode({'userId': userId}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      log(response.body);
      return (json.decode(response.body) as List)
          .map((data) => ConversationModel.fromJson(data))
          .toList();
    } else {
      log(response.body);
      throw Exception('Failed to load messages');
    }
  }

  static Future<Map<String, dynamic>?> getUserInfo(String userId) async {
    const url = "http://10.0.2.2:8081/getUserInfo";
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.post(Uri.parse(url),
        body: json.encode({'userId': userId}), headers: headers);
    log(response.body);

    if (response.statusCode == 200) {
      log(response.body);
      return json.decode(response.body);
    } else {
      log(response.body);
      throw Exception('Failed to load user info');
    }
  }

  static Future<String> getMessage(String messageId) async {
    const url = "$baseUrl/chats/getMessage";
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.post(Uri.parse(url),
        body: json.encode({'messageId': messageId}), headers: headers);

    if (response.statusCode == 200) {
      log(response.body);
      return json.decode(response.body);
      //return MessageModel.fromJson(json.decode(response.body));
    } else {
      //log(response.body);
      throw Exception('Failed to get the message');
    }
  }
}

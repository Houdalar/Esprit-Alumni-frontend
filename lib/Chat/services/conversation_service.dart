import 'dart:convert';
import 'dart:developer';
import 'package:esprit_alumni_frontend/Chat/Models/message.dart';
import 'package:http/http.dart' as http;

class ConversationService {
  static Future<List<Message>> getConversationMessages(
      int sourceId, int targetId) async {
    final response = await http.post(
        Uri.parse('http://172.17.0.105:3000/chats/getConversationMessages'),
        body: json.encode({'sourceId': sourceId, 'targetId': targetId}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      log(response.body);
      return (json.decode(response.body) as List)
          .map((data) => Message.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load conversations');
    }
  }
}

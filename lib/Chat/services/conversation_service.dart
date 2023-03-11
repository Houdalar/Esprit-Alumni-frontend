import 'dart:convert';
import 'package:esprit_alumni_frontend/Chat/Models/message.dart';
import 'package:http/http.dart' as http;

class ConversationService {
  static Future<List<Message>> getConversationMessages(
      int sourceId, int targetId) async {
    final response = await http.post(
        Uri.parse('http://192.168.1.44:3000/chats/getConversationMessages'),
        body: {'sourceId': sourceId, 'targetId': targetId});
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((data) => Message.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load conversations');
    }
  }
}

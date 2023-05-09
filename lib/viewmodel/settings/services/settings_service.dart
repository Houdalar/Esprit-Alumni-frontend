import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static String baseUrl = "http://10.0.2.2:8081";

  static Future<Map<String, dynamic>> updatePassword(
      String id, String curentpassword, String newpassword) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    final response = await http.post(Uri.parse('$baseUrl/updatepassword'),
        headers: headers,
        body: jsonEncode({
          "id": id,
          "curentpassword": curentpassword,
          "newpassword": newpassword
        }));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update password');
    }
  }

  static Future<void> updateUsername(String username, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    try {
      final response = await http.post(Uri.parse('$baseUrl/updateUsername'),
          body: jsonEncode({
            'token': token,
            'username': username,
          }),
          headers: headers);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        String updatedUsername = responseBody['username'];
        prefs.setString("username", updatedUsername);
      } else {
        throw Exception('Failed to update username');
      }
    } catch (e) {
      throw Exception('Failed to update username');
    }
  }
}

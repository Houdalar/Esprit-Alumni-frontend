import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../view/screens/home.dart';
import '../../view/components/themes/colors.dart';

class UserViewModel extends ChangeNotifier {
  final BuildContext context;
  String baseUrl = "10.0.2.2:8081";

  UserViewModel({required this.context});

  Future<void> login(String? email, String? password) async {
    Map<String, dynamic> userData = {"email": email, "password": password};

    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    http
        .post(Uri.http(baseUrl, "/login"),
            body: json.encode(userData), headers: headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        // Map<String, dynamic> userData = json.decode(response.body);

        // Shared preferences
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString("userId", userData["_id"]);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
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
  }
}

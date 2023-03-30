import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../components/constum_componenets/gradientButton.dart';
import '../components/themes/colors.dart';
import '../../viewmodel/userViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class reset3Page extends StatefulWidget {
  const reset3Page({Key? key}) : super(key: key);

  @override
  _reset3PageState createState() => _reset3PageState();
}

class _reset3PageState extends State<reset3Page> {
  String? _email;
  String? _password;
  String? _confirmPassword;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  Future<String?> _getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("email") as String?;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mailphoto = Container(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset("media/Reset password-cuate (1).png"),
    );

    final password = TextFormField(
      onSaved: (String? value) {
        _password = value;
      },
      minLines: 1,
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'password',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryDark),
          borderRadius: BorderRadius.circular(32.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(32.0),
        ),
        filled: true,
        fillColor: AppColors.darkwhite,
        prefixIcon: const Icon(
          Icons.lock,
          color: AppColors.darkgray,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
    final confirmPassword = TextFormField(
      onSaved: (String? value) {
        _confirmPassword = value;
      },
      minLines: 1,
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'confirm password',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryDark),
          borderRadius: BorderRadius.circular(32.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(32.0),
        ),
        filled: true,
        fillColor: AppColors.darkwhite,
        prefixIcon: const Icon(
          Icons.lock,
          color: AppColors.darkgray,
        ),
      ),
      validator: (value) {
        _keyForm.currentState!.save();
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != _password) {
          return 'Passwords do not match';
        }
        return null;
      },
    );

    final sendButton = Container(
      //padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
      width: double.infinity,
      child: gradientButton(
        borderRadius: BorderRadius.circular(30.0),
        width: double.infinity,
        height: 60.0,
        gradient: AppColors.gradient1,
        child: const Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.0,
            fontFamily: 'Mukata Malar',
          ),
        ),
        onPressed: () {
          if (_keyForm.currentState!.validate()) {
            _keyForm.currentState!.save();
            _getEmail().then((value) {
              _email = value;
              UserViewModel.resetpassword(_email, _password, context);
            });
          }
        },
      ),
    );

    return Scaffold(
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 350.0,
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: mailphoto,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(35, 0, 35, 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('Great ! ',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 25,
                          fontFamily: 'Mukata Malar',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center),
                    SizedBox(
                      height: 20,
                    ),
                    Text('choose a new password ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Mukata Malar',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center),
                  ]),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 10, 35, 30),
              child: password,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 0, 35, 40),
              child: confirmPassword,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 10, 35, 40),
              child: sendButton,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../components/constum_componenets/gradientButton.dart';
import '../components/themes/colors.dart';
import '../../viewmodel/userViewModel.dart';

class reset1Page extends StatefulWidget {
  const reset1Page({Key? key}) : super(key: key);

  @override
  reset1PageState createState() => reset1PageState();
}

class reset1PageState extends State<reset1Page> {
  String? _email;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mailphoto = SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset("media/Mailbox-pana.png"),
    );

    final email = TextFormField(
      onSaved: (String? value) {
        _email = value;
      },
      minLines: 1,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Email',
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
          Icons.email,
          color: AppColors.darkgray,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email address';
        }
        if (!EmailValidator.validate(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );

    final sendButton = SizedBox(
      width: double.infinity,
      child: gradientButton(
        borderRadius: BorderRadius.circular(30.0),
        width: double.infinity,
        height: 60.0,
        gradient: AppColors.gradient1,
        child: const Text(
          'Send',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.0,
            fontFamily: 'Mukata Malar',
          ),
        ),
        onPressed: () {
          if (_keyForm.currentState!.validate()) {
            _keyForm.currentState!.save();
            UserViewModel.forgotPassword(_email, context);
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
                    Text('Oops! ',
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
                    Text('Looks like you\'ve forgotten your password. ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Mukata Malar',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center),
                    SizedBox(
                      height: 20,
                    ),
                    Text('No worries, we\'ve got you covered!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Mukata Malar',
                        ),
                        textAlign: TextAlign.center),
                  ]),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 10, 35, 40),
              child: email,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 0, 35, 40),
              child: sendButton,
            ),
          ],
        ),
      ),
    );
  }
}

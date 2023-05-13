import 'package:esprit_alumni_frontend/view/screens/rsetpassword1.dart';
import 'package:esprit_alumni_frontend/view/screens/signup1.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../../socketService.dart';
import '../components/constum_componenets/gradientButton.dart';
import '../components/themes/colors.dart';
import '../../viewmodel/userViewModel.dart';

class LoginPage extends StatefulWidget {
  final SocketService socketService;
  static String tag = 'login-page';

  const LoginPage({super.key, required this.socketService});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late String? _email;
  late String? _password;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Container(
      height: 150.0,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 10),
      child: Image.asset("media/logo.png"),
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

    final password = TextFormField(
      obscureText: true,
      onSaved: (String? value) {
        _password = value;
      },
      minLines: 1,
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      autofocus: true,
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

    final loginButton = SizedBox(
      //padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
      width: double.infinity,
      child: gradientButton(
        borderRadius: BorderRadius.circular(30.0),
        width: double.infinity,
        height: 60.0,
        gradient: AppColors.gradient1,
        child: const Text(
          'SIGN IN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.0,
            fontFamily: 'Mukata Malar',
          ),
        ),
        onPressed: () {
          if (_keyForm.currentState!.validate()) {
            _keyForm.currentState!.save();
            UserViewModel.login(
                _email, _password, context, widget.socketService);
          }
        },
      ),
    );

    final googleButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.primaryDark,
        backgroundColor: Colors.white,
        fixedSize: const Size.fromHeight(60),
        elevation: 3,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: AppColors.primaryDark, width: 1),
        ),
      ),
      onPressed: () {
        UserViewModel.signInWithGoogle(context);
      },
      icon: Image.asset("media/google-icon.png", height: 24),
      label: const Text('Continue with Google',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.0,
            fontFamily: 'Mukata Malar',
          )),
    );

    return Scaffold(
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 200.0,
              margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
              child: logo,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 0, 35, 20),
              child: email,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 20, 35, 10),
              child: password,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 10, 40, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //add a chekbox here

                  const Spacer(),
                  GestureDetector(
                    child: const Text("Forgot your password ?",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const reset1Page()),
                      );
                    },
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 35, 35, 20),
              child: loginButton,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(35, 20, 35, 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 50.0,
                    child: Divider(
                      color: Colors.black,
                      height: 30.0,
                    ),
                  ),
                  Text(
                    '  Or sign in with  ',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    width: 50.0,
                    child: Divider(
                      color: Colors.black,
                      height: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 10, 35, 10),
              child: googleButton,
            ),
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.fromLTRB(35, 25, 35, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account ?",
                        style: TextStyle(fontSize: 15)),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      child: const Text("Sign up",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

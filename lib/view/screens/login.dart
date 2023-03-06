import 'package:esprit_alumni_frontend/view/screens/rsetpassword1.dart';
import 'package:esprit_alumni_frontend/view/screens/signup1.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/constum_componenets/gradientButton.dart';
import '../components/themes/colors.dart';
import '../../viewmodel/userViewModel.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  const LoginPage({super.key});

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String? _email;
  late String? _password;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  bool _rememberMe = false;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _isBiometricSupported = false;
  bool _isBiometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkBiometric();
  }

  Future<void> _checkBiometric() async {
    try {
      _isBiometricSupported = await _localAuthentication.isDeviceSupported();
      _isBiometricEnabled = await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      print(e);
    }
    if (!_isBiometricSupported) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Fingerprint Authentication'),
          content:
              Text('Your device does not support biometric authentication'),
        ),
      );
    } else if (!_isBiometricEnabled) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Fingerprint Authentication'),
          content: Text('You have not enabled biometric authentication'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Container(
      height: 150.0,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 10),
      child: Image.asset("media/logo.png"),
    );

    final fingerprint = Container(
        height: 100.0,
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: GestureDetector(
          child: Image.asset("media/fgprint.png"),
          onTap: () async {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      title: const Text("Login with fingerprint",
                          style: TextStyle(color: AppColors.primary)),
                      content: Container(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "media/Fingerprint-cuate.png",
                            height: 300,
                            width: 300,
                          ),
                          const Text(
                              "Please place your finger on the fingerprint sensor"),
                        ],
                      )));
                });
            // UserViewModel.authenticate(context);
          },
        ));

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
        const String pattern = r'^[a-zA-Z0-9]+.[a-zA-Z0-9]+@esprit\.tn$';
        RegExp regExp = RegExp(pattern);
        if (value == null || value.isEmpty) {
          return 'Please enter an email address';
        }
        if (!EmailValidator.validate(value)) {
          return 'Please enter a valid email address';
        }
        if (!regExp.hasMatch(value)) {
          return 'Please enter an email address from esprit.tn';
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

    final rememberMe = Container(
      child: Row(
        children: [
          Checkbox(
            value: _rememberMe,
            onChanged: (value) {
              setState(() async {
                _rememberMe = value!;
                // saved in shared preferences to be used later
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("rememberme", _rememberMe.toString());
              });
            },
            activeColor: AppColors.primaryDark,
          ),
          const Text(
            'Remember me',
            style: TextStyle(
              color: AppColors.darkgray,
              fontSize: 17.0,
              fontFamily: 'Mukata Malar',
            ),
          ),
        ],
      ),
    );

    final loginButton = Container(
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
            UserViewModel.login(_email, _password, context);
          }
        },
      ),
    );

    final googleButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(60),
        primary: Colors.white,
        onPrimary: AppColors.primaryDark,
        elevation: 3,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: AppColors.primaryDark, width: 1),
        ),
      ),
      onPressed: () {},
      icon: Image.asset("media/google-icon.png", height: 24),
      label: const Text('Continue with Google',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.0,
            fontFamily: 'Mukata Malar',
          )),
    );

    //final googleButton = GoogleSignInButton();

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
                  Checkbox(
                      activeColor: AppColors.primaryDark,
                      value: _rememberMe,
                      onChanged: (newValue) {
                        setState(() {
                          _rememberMe = newValue ?? false;
                        });
                      }),
                  Text('Remember me'),
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
                children: [
                  Container(
                    width: 50.0,
                    child: const Divider(
                      color: Colors.black,
                      height: 30.0,
                    ),
                  ),
                  const Text(
                    '  Or sign in with  ',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(
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
              margin: const EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: fingerprint,
            ),
            Container(
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
          ],
        ),
      ),
    );
  }
}

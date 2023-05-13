import 'package:esprit_alumni_frontend/presentation/core/colors.dart';
import 'package:esprit_alumni_frontend/presentation/core/gradientButton.dart';
import 'package:esprit_alumni_frontend/presentation/core/user_admin.dart';
import 'package:esprit_alumni_frontend/presentation/core/web_dashboard_app.dart';
import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPageW extends StatefulWidget {
  const LoginPageW({Key? key}) : super(key: key);

  @override
  State<LoginPageW> createState() => _LoginPageWState();
}

class _LoginPageWState extends State<LoginPageW> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoggingIn = false;

  // ValidateCredentials -----------------------------------------------------------
  /*bool _validateCredentials() {
    UserAdmin admin1 = UserAdmin(
        email: "admin1@esprit.tn", password: "admin1", subscription: true);
    UserAdmin admin2 = UserAdmin(
        email: "admin2@esprit.tn", password: "admin2", subscription: false);
    return _emailController.text == admin1.email &&
            _passwordController.text == admin1.password ||
        _emailController.text == admin2.email &&
            _passwordController.text == admin2.password;
  }*/

  // CheckSubscription -----------------------------------------------------------
  /*bool _checkSubscription() {
    UserAdmin admin1 = UserAdmin(
        email: "admin1@esprit.tn", password: "admin1", subscription: true);
    UserAdmin admin2 = UserAdmin(
        email: "admin2@esprit.tn", password: "admin2", subscription: false);
    return admin1.subscription || admin2.subscription;
  }*/

  // Login Button ------------------------------------------------------------------
  void _handleLoginButtonPressed() {
    Color _loadingColor = Color.fromARGB(255, 190, 0, 0);
    UserAdmin admin1 = UserAdmin(
        email: "admin1@esprit.tn", password: "admin1", subscription: true);
    UserAdmin admin2 = UserAdmin(
        email: "admin2@esprit.tn", password: "admin2", subscription: false);
    // Show a loading indicator while checking credentials
    setState(() {
      _isLoggingIn = true;
      _loadingColor;
    });
    Future.delayed(
      Duration(seconds: 1, milliseconds: 200),
      () {
        // Hide the loading indicator
        setState(() {
          _isLoggingIn = false;
        });
        // Validate the credentials
        if (_emailController.text == admin1.email &&
            _passwordController.text == admin1.password) {
          if (admin1.subscription) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WebDashboardApp()),
            );
          } else {
            // Show an alert that subscription is required
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Access Denied"),
                  content:
                      Text("You need to subscribe to access this service."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
        } else if (_emailController.text == admin2.email &&
            _passwordController.text == admin2.password) {
          if (admin2.subscription) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WebDashboardApp()),
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Access Denied"),
                  content:
                      Text("You need to subscribe to access this service."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
        } else {
          // Show an alert that credentials are incorrect
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Wrong Credentials"),
                content:
                    Text("The email or password you entered is incorrect."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color _loadingColor = Color.fromARGB(255, 190, 0, 0);
    // login UI

    return Scaffold(
      body: Container(
        color:
            Color.fromARGB(255, 255, 255, 255), // set the background color here
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double screenWidth = constraints.maxWidth;
            bool isSmallScreen = screenWidth < 768;
            return Row(
              children: [
                if (!isSmallScreen)
                  Expanded(
                      child: Column(
                    children: [
                      SizedBox(height: 100.0),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('WELCOME  TO  OUR  COMMUNITY !',
                            style: TextStyle(
                              color: Color.fromARGB(255, 92, 2, 2),
                              fontSize: isSmallScreen ? 24.0 : 36.0,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Mukta Malar',
                            )),
                      ),
                      SizedBox(height: 20.0),
                      Image.asset(
                        'Assets/images/welcome.png',
                        height: 400.0,
                      ),
                    ],
                  )),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 30.0 : 60.0,
                      vertical: isSmallScreen ? 80.0 : 100.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 30.0,
                                  bottom: 40.0,
                                  left: 20.0,
                                  right: 20.0),
                              child: Text(
                                'Login To Your Account',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 24.0 : 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Image.asset(
                            'Assets/images/logo.png',
                            height: 100.0,
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 45.0, right: 45.0, bottom: 10.0),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _emailController,
                                  minLines: 1,
                                  maxLines: 1,
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColorsH.primaryDark),
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                    filled: true,
                                    fillColor: AppColorsH.darkwhite,
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: AppColorsH.darkgray,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 22.0),
                                TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  minLines: 1,
                                  maxLines: 1,
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColorsH.primaryDark),
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                    filled: true,
                                    fillColor: AppColorsH.darkwhite,
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: AppColorsH.darkgray,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                _isLoggingIn
                                    ? CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                _loadingColor),
                                      )
                                    : Container(
                                        //padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                                        width: double.infinity,
                                        child: gradientButton(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          width: double.infinity,
                                          height: 45.0,
                                          gradient: AppColors.gradient1,
                                          child: const Text(
                                            'SIGN IN',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontFamily: 'Mukata Malar',
                                            ),
                                          ),
                                          onPressed: _handleLoginButtonPressed,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


/*
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
          borderSide: BorderSide(color: AppColors.primaryDark),
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
        borderRadius: BorderRadius.circular(20.0),
        width: double.infinity,
        height: 45.0,
        gradient: AppColors.gradient1,
        child: const Text(
          'SIGN IN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontFamily: 'Mukata Malar',
          ),
        ),
        onPressed: () {
          if (_keyForm.currentState!.validate()) {
            _keyForm.currentState!.save();
            if (_email == _email || _password == _password) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WebMain()),
              );
            } /*else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Error"),
                    content: const Text("Wrong email or password"),
                    actions: [
                      TextButton(
                        child: const Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }*/
          }
        },
      ),
    );
 */

import 'package:esprit_alumni_frontend/view/screens/restpassword3.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../viewmodel/userViewModel.dart';
import '../components/constum_componenets/gradientButton.dart';
import '../components/themes/colors.dart';

class reset2Page extends StatefulWidget {
  final String? token;
  final String? code = "";
  const reset2Page(this.token, {Key? key}) : super(key: key);

  @override
  reset2PageState createState() => reset2PageState();
}

class reset2PageState extends State<reset2Page> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<String?> getEmail() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString("email");
    }

    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();
    final TextEditingController controller3 = TextEditingController();
    final TextEditingController controller4 = TextEditingController();
    String? email;

    final mailphoto = SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset("media/My password-pana.png"),
    );

    final codefield = Container(
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _textFieldOTP(first: true, last: false, controller: controller1),
          const SizedBox(width: 5),
          _textFieldOTP(first: false, last: false, controller: controller2),
          const SizedBox(width: 5),
          _textFieldOTP(first: false, last: false, controller: controller3),
          const SizedBox(width: 5),
          _textFieldOTP(first: false, last: true, controller: controller4),
        ],
      ),
    );

    Future<void> verifyCode() async {
      final String code = controller1.text +
          controller2.text +
          controller3.text +
          controller4.text;

      if (widget.token == code) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const reset3Page()));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: const Text("Wrong Code",
                      style: TextStyle(color: AppColors.primary)),
                  content: Image.asset(
                    "media/Warning-cuate.png",
                    height: 300,
                    width: 300,
                  ));
            });
      }
    }

    final verifyButton = SizedBox(
      width: double.infinity,
      child: gradientButton(
        borderRadius: BorderRadius.circular(30.0),
        width: double.infinity,
        height: 60.0,
        gradient: AppColors.gradient1,
        child: const Text(
          'Verify',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.0,
            fontFamily: 'Mukata Malar',
          ),
        ),
        onPressed: () {
          verifyCode();
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
              margin: const EdgeInsets.fromLTRB(35, 40, 35, 30),
              child: Column(
                children: const [
                  Text('You\'re almost there !',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 25,
                        fontFamily: 'Mukata Malar',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                  SizedBox(height: 15),
                  Text('Check your email for a code and enter it below',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Mukata Malar',
                      ),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 230.0,
              margin: const EdgeInsets.fromLTRB(35, 0, 35, 30),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    codefield,
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                      child: verifyButton,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Didn\'t receive the email?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Mukata Malar',
                    ),
                    textAlign: TextAlign.center),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  child: const Text('Resend Code',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 15,
                        fontFamily: 'Mukata Malar',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center),
                  onTap: () {
                    getEmail().then((value) {
                      email = value;
                      UserViewModel.forgotPassword(email, context);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _textFieldOTP(
      {required bool first, last, TextEditingController? controller}) {
    return SizedBox(
      height: 85,
      width: 70,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: AppColors.lightgray),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: AppColors.primary),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}

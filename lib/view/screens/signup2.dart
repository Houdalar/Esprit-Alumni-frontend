import 'package:flutter/material.dart';

import '../components/constum_componenets/gradientButton.dart';
import '../components/themes/colors.dart';
import './home.dart';

import '../../viewmodel/userViewModel.dart';

class Signup2Page extends StatefulWidget {
  final String? email;
  final String? password;
  final String? name;

  const Signup2Page(this.email, this.name, this.password, {Key? key})
      : super(key: key);

  @override
  _Signup2PageState createState() => _Signup2PageState();
}

List<String> _level = [
  'First Year',
  'Second Year',
  'Third Year',
  'Fourth Year',
  'Fifth Year',
];

List<String> _speciality = [
  'ITC',
  'TC',
  'GC',
  'GE',
];

List<String> _tic = [
  "ds",
  "arctic",
  "twin",
  "infini",
  "sae",
  "erp-bi",
  "sleam",
  "sim",
  "nids",
  "se"
];

class _Signup2PageState extends State<Signup2Page> {
  final Map<String, List<String>> _options = {
    'ITC': [
      "ds",
      "arctic",
      "twin",
      "infini",
      "sae",
      "erp-bi",
      "sleam",
      "sim",
      "nids",
      "se"
    ],
    'TC': ['Siamese', 'Persian', 'Bengal'],
    'GC': ['Arabian', 'Thoroughbred', 'Quarter Horse'],
    'GE': ['Arabian', 'Thoroughbred', 'Quarter Horse'],
  };
  String? selectedGender;
  int? _selectedValue;

  DateTime? _selectedDate;
  String? _selectedLevel;
  String? _selectedSpecialization;
  String? _selectedOption;
  List<String> _optionsList = [];

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primary, // header background color
            accentColor: AppColors.primaryDark, // selection color
            colorScheme: ColorScheme.light(primary: AppColors.primaryDark),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

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

    final signupButton = Container(
      //padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
      width: double.infinity,
      child: gradientButton(
        borderRadius: BorderRadius.circular(30.0),
        width: double.infinity,
        height: 60.0,
        gradient: AppColors.gradient1,
        child: const Text(
          'SIGN UP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.0,
            fontFamily: 'Mukata Malar',
          ),
        ),
        onPressed: () {
          if (_keyForm.currentState!.validate()) {
            _keyForm.currentState!.save();
            UserViewModel.signup(
                widget.email,
                widget.password,
                widget.name,
                selectedGender.toString(),
                _selectedOption,
                _selectedDate.toString(),
                _selectedLevel,
                _selectedSpecialization,
                context);
          }
        },
      ),
    );

    final dateButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(40),
        primary: Colors.white,
        onPrimary: AppColors.primaryDark,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: const BorderSide(color: AppColors.primaryDark, width: 1),
        ),
      ),
      onPressed: () {
        _selectDate(context);
      },
      icon: const Icon(
        Icons.calendar_today,
        color: AppColors.primaryDark,
      ),
      label: const Text('choose date',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.0,
            fontFamily: 'Mukata Malar',
          )),
    );

    final level = DropdownButtonFormField<String>(
      value: _selectedLevel,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: 'Choose your level',
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryDark),
      iconSize: 24,
      isExpanded: true,
      items: _level
          .map((option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedLevel = value;
        });
      },
    );

    final speciality = DropdownButtonFormField<String>(
      value: _selectedSpecialization,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: 'Choose your speciality',
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryDark),
      iconSize: 24,
      isExpanded: true,
      items: _speciality
          .map((option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedSpecialization = value;
          _optionsList = _options[_selectedSpecialization]!;
        });
      },
    );

    final option = DropdownButtonFormField<String>(
      value: _selectedOption,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: 'Choose your option',
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryDark),
      iconSize: 24,
      isExpanded: true,
      items: _optionsList
          .map((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedOption = value;
        });
      },
    );

    return Scaffold(
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 35, 35, 10),
              child: const Text(
                "Gender :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: "Male",
                    groupValue: selectedGender,
                    fillColor: MaterialStateProperty.all(AppColors.primary),
                    onChanged: (value) =>
                        setState(() => selectedGender = value?.toString()),
                  ),
                  const Text(
                    'Male',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: "Female",
                    groupValue: selectedGender,
                    fillColor: MaterialStateProperty.all(AppColors.primary),
                    onChanged: (value) =>
                        setState(() => selectedGender = value?.toString()),
                  ),
                  const Text('Female'),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 20, 35, 20),
              child: const Text(
                "Date of birth :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(80, 0, 80, 20),
              child: dateButton,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 10, 35, 20),
              child: const Text(
                "Level :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(80, 0, 80, 20),
              child: level,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 10, 35, 20),
              child: const Text(
                "Speciality :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(80, 0, 80, 20),
              child: speciality,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 10, 35, 20),
              child: const Text(
                "Option :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(80, 0, 80, 20),
              child: option,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 35, 35, 20),
              child: signupButton,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(35, 35, 35, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You have an account ?",
                      style: TextStyle(fontSize: 15)),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    child: const Text("Sign in",
                        style:
                            TextStyle(color: AppColors.primary, fontSize: 15),
                        textAlign: TextAlign.center),
                    onTap: () {},
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

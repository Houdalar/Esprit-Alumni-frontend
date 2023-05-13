import 'package:flutter/material.dart';

import '../../../viewmodel/userViewModel.dart';
import '../../components/constum_componenets/gradientButton.dart';
import '../../components/themes/colors.dart';

class InfoPopup extends StatefulWidget {
  const InfoPopup({Key? key}) : super(key: key);

  @override
  State<InfoPopup> createState() => _InfoPopupState();
}

List<String> _level = [
  'First Year',
  'Second Year',
  'Third Year',
  'Fourth Year',
  'Fifth Year',
  'Alumni',
];

List<String> _speciality = [
  'ITC',
  'TC',
  'GC',
  'GE',
];

class _InfoPopupState extends State<InfoPopup> {
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
    'TC': ['win', 'iosys'],
    'GC': ['oge', 'ue', 'eco', 'ues'],
    'GE': ['ogi', 'mec'],
  };

  String? _selectedLevel;
  String? _selectedSpecialization;
  String? _selectedOption;
  List<String> _optionsList = [];

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signupButton = SizedBox(
      child: gradientButton(
        borderRadius: BorderRadius.circular(30.0),
        width: double.infinity,
        height: 60.0,
        gradient: AppColors.gradient1,
        child: const Text(
          'UPDATE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.0,
            fontFamily: 'Mukata Malar',
          ),
        ),
        onPressed: () {
          if (_keyForm.currentState!.validate()) {
            _keyForm.currentState!.save();
            /* UserViewModel().updateUser(
              level: _selectedLevel,
              specialization: _selectedSpecialization,
              option: _selectedOption,
            );*/
          }
        },
      ),
    );
    final level = DropdownButtonFormField<String>(
      value: _selectedLevel,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      icon: const Icon(Icons.arrow_drop_down, color: AppColors.primaryDark),
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

    final option = DropdownButtonFormField<String>(
      value: _selectedOption,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      icon: const Icon(Icons.arrow_drop_down, color: AppColors.primaryDark),
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

    final speciality = DropdownButtonFormField<String>(
      value: _selectedSpecialization,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      icon: const Icon(Icons.arrow_drop_down, color: AppColors.primaryDark),
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
    return Scaffold(
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
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
            if (['Fourth Year', 'Fifth Year', 'Alumni']
                .contains(_selectedLevel))
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
            if (['Fourth Year', 'Fifth Year', 'Alumni']
                .contains(_selectedLevel))
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
          ],
        ),
      ),
    );
  }
}

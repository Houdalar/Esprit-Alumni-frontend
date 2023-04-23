import 'package:flutter/material.dart';
import 'package:esprit_alumni_frontend/viewmodel/profileViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreen();
}

class _EducationScreen extends State<EducationScreen> {
  List<String> universities = [
    "Faculté des Sciences de Tunis (FST)",
    "Faculté des Sciences Economiques et de Gestion de Tunis (FSEGT)",
    "Ecole Nationale des Sciences de l'Informatique (ENSI)",
    "Ecole Supérieure des Communications de Tunis (Sup'Com)",
    "Institut Supérieur d'Informatique de Mahdia (ISIMa)",
    "Institut Supérieur des Etudes Technologiques de Nabeul (ISET Nabeul)",
    "Institut Supérieur des Etudes Technologiques de Sousse (ISET Sousse)",
    "Institut Supérieur des Etudes Technologiques de Tunis (ISET Tunis)",
    "Institut Supérieur des Sciences Appliquées et de Technologie de Sousse (ISSAT Sousse)",
    "Institut Supérieur des Sciences Appliquées et de Technologie de Tunis (ISSAT Tunis)",
    "Ecole Polytechnique de Tunisie (EPT)",
    "Ecole Nationale des Ingénieurs de Sfax (ENIS)",
    "Ecole Nationale des Ingénieurs de Tunis (ENIT)",
    "Ecole Supérieure des Technologies Avancées (ESTA)",
    "Ecole Supérieure des Sciences et Technologies de l'Ingénieur de Tunis (ESSTI)",
    "Ecole Nationale des Sciences Appliquées de Sidi Bouzid (ENISB)",
    "Ecole Nationale des Sciences de l'Informatique de Manouba (ENSI)",
    "Ecole Nationale des Sciences de l'Informatique de la Manouba (ENSI)",
    "Ecole Supérieure de Commerce Electronique de Tunis (ESCE)",
    "Ecole Supérieure de Commerce de Tunis (ESCT)",
    "Ecole Supérieure des Communications de Sousse (Sup'Com)",
    "Institut National des Sciences Appliquées et de Technologie de Tunis (INSAT)",
    "Institut Préparatoire aux Etudes d'Ingénieurs de Tunis (IPEIT)",
    "Institut Supérieur d'Electronique et de Communication de Sfax (ISECS)",
    "Institut Supérieur de Gestion de Tunis (ISG Tunis)",
    "Institut Supérieur des Etudes Technologiques de Kairouan (ISET Kairouan)",
    "Institut Supérieur des Etudes Technologiques de Médenine (ISET Médenine)",
    "Institut Supérieur des Etudes Technologiques de Sidi Bouzid (ISET Sidi Bouzid)",
    "Institut Supérieur des Etudes Technologiques de Zaghouan (ISET Zaghouan)",
    "Institut Supérieur des Sciences Humaines de Tunis (ISSHT)",
    "Institut Supérieur des Sciences et Techniques de l'Information et de la Communication de Kairouan (ISTIC)",
    "Institut Supérieur des Sciences Appliquées et de Technologie de Gabès (ISSAT Gabès)",
    "Institut Supérieur des Sciences Biologiques Appliquées de Tunis (ISSBAT)",
    "Institut Supérieur des Sciences Humaines de Sousse (ISSHS)",
    "Institut Supérieur des Sciences Humaines de Tunis de la Manouba (ISSHTM)",
    "Institut Supérieur des Technologies de l'Information et de la Communication de Hammam Sousse (ISTIC HS)",
    "Institut Supérieur Privé des Technologies de l'Information et de la Communication (ISPTIC)",
    "Institut Tunisien de Formation Bancaire (ITFB)",
    "Institut Tunisien des Technologies de l'Education (ITTE)",
    "Université Centrale (UC)",
  ];

  List<String> filteredUniversities = [];
  TextEditingController searchController = TextEditingController();
  String selectedUniversity = '';
  bool showFilteredList = false;
  late SharedPreferences _prefs;
  String? token = "";

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  void filterUniversities(String query) {
    List<String> filteredList = [];
    for (var university in universities) {
      if (university.toLowerCase().startsWith(query.toLowerCase())) {
        filteredList.add(university);
      }
    }
    setState(() {
      filteredUniversities = filteredList;
      showFilteredList = true;
    });
  }

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      token = _prefs.getString('userId') ?? "";
    });
  }

  // UI -------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 40.0, bottom: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'media/esprit_logo.png',
                    height: 80,
                    width: 110,
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      'Ecole supérieur privée d\'ingénierie et de technologie',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              if (selectedUniversity != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 30.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'media/other_university.png',
                        height: 80,
                        width: 110,
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          selectedUniversity,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              TextButton(
                onPressed: () async {
                  await ProfileViewModel.updateEducation(
                      token!, selectedUniversity);
                  Navigator.pop(context, selectedUniversity);
                  setState(() async {
                    await ProfileViewModel.fetchProfile(token!);
                  });
                },
                child: const Text(
                  'SAVE',
                  style: TextStyle(
                    color: Color.fromARGB(255, 177, 5, 5),
                    fontSize: 18.0,
                    fontFamily: 'Mukata Malar',
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    cursorColor: Colors.grey,
                    controller: searchController,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          showFilteredList = false;
                        });
                      } else {
                        filterUniversities(value);
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 148, 34, 26),
                            width: 0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Add other university",
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 209, 41, 29),
                      ),
                    ),
                  ),
                ),
              ),
              if (showFilteredList)
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredUniversities.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(filteredUniversities[index]),
                        onTap: () {
                          setState(() {
                            selectedUniversity = filteredUniversities[index];
                            showFilteredList = false;
                            filteredUniversities.clear();
                            searchController.clear();
                          });
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

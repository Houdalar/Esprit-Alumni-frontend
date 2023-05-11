import 'package:esprit_alumni_frontend/view/screens/Profile/civil.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/computer_science.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/electro.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/telecom.dart';
import 'package:flutter/material.dart';

class Specialties extends StatefulWidget {
  const Specialties({super.key});

  @override
  State<Specialties> createState() => _SpecialtiesState();
}

class _SpecialtiesState extends State<Specialties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 22,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Specialties Taught At Esprit',
                    style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mukta Malar'),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildContainerXL(
                      Icons.computer,
                      'COMPUTER SCIENCE',
                      'Mastery of software engineering techniques (methods, languages & tools) and user interaction for the design of embedded software and information systems.',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ComputerScience()),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    _buildContainerXL(
                      Icons.network_check,
                      'TELECOMMUNICATIONS',
                      'Participate in the optimization of communication systems, from research to the design of equipment and services, through network infrastructure management.',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Telecommunications()),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    _buildContainerXL(
                      Icons.construction_outlined,
                      'CIVIL ENGINEERING',
                      'Work on designing new structures, assessing the safety and stability of existing structures, and developing plans to manage environmental risks.',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Civil()),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    _buildContainerXL(
                      Icons.miscellaneous_services,
                      'ELECTROMECHANICS',
                      'Work on designing control systems for machines and robots to developing renewable energy systems.',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Electromechanics()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainerXL(
      IconData iconData, String title, String text, VoidCallback onTap) {
    return GestureDetector(
      //onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.17,
        height: MediaQuery.of(context).size.height / 2.96,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    iconData,
                    size: 40.0,
                    color: const Color.fromARGB(255, 112, 0, 0),
                  ),
                  //Image.asset(imagePath, width: 40.0, height: 40.0),
                  const SizedBox(width: 15),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mukta Malar',
                        color: Color.fromARGB(255, 178, 0, 0)),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                text,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Mukta Malar',
                    color: Colors.grey[800]),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(width: 190),
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 178, 0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('See More..',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Mukta Malar',
                            color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

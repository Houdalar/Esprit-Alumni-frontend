import 'package:esprit_alumni_frontend/view/screens/Profile/specialties.dart';
import 'package:flutter/material.dart';

import '../../components/constum_componenets/job_chart.dart';
import 'geographical_dest.dart';
import 'in_demand.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Dashboard',
                  style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mukta Malar'),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildContainerXL(
                    'media/fields.png',
                    'In-Demand Fields',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              in_demand(title: "In-Demand Fields")),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildContainer(
                        'media/specialties.png',
                        'Specialties Taught',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Specialties()),
                        ),
                      ),
                      _buildContainer(
                        'media/employer.png',
                        'Employer Information',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Specialties()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildContainer(
                        'media/geographic.png',
                        'Geographical Distribution',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const GeographicalDistribution()),
                        ),
                      ),
                      _buildContainer(
                        'media/career.png',
                        'popular Career Paths',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => JobChart()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(String imagePath, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
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
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 0.0, left: 4.0, right: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(imagePath, width: 80.0, height: 80.0),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 3.0, left: 4.0, right: 4),
                child: Text(text,
                    style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mukta Malar'),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainerXL(String imagePath, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.17,
        height: MediaQuery.of(context).size.height / 3.8,
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
          padding:
              const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 4.0, right: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 145.0, height: 145.0),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 4.0, left: 4.0, right: 4),
                child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mukta Malar'),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

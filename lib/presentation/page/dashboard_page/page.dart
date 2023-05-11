import 'package:flutter/material.dart';
import 'package:esprit_alumni_frontend/presentation/page/dashboard_page/components/geographical.dart';

import 'package:esprit_alumni_frontend/presentation/page/dashboard_page/components/in_demand_fields.dart';

import 'package:esprit_alumni_frontend/presentation/page/dashboard_page/components/information_row.dart';
import 'package:esprit_alumni_frontend/presentation/page/dashboard_page/components/popular_fields.dart';
import 'package:esprit_alumni_frontend/presentation/page/dashboard_page/components/statistics_box/specialties.dart';
import 'package:esprit_alumni_frontend/presentation/theme/text_styles.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 20, 40),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Text(
              'Welcome back !',
              style: TextStyles.myriadProSemiBold32DarkBlue,
            ),
          ),
          const SizedBox(height: 28),
          const InformationRow(),
          const SizedBox(height: 22),
          Wrap(
            spacing: 22,
            runSpacing: 22,
            children: <Widget>[
              const Specialties(), // The specialties taught at Esprit Card
              PopularFields(),
              in_demand(), // The most in demand fields Card
              const GeographicalDistribution(), // The most popular fields among esprit Card
            ],
          ),
          const SizedBox(height: 22),
          /*Wrap(
            spacing: 22,
            runSpacing: 22,
            children: <Widget>[
              in_demand(), // The most in demand fields Card
              const GeographicalDistribution(), // The geographical distribution of Alumni Card
            ],
          ),*/
        ],
      ),
    );
  }
}

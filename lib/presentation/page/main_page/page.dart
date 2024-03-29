import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:esprit_alumni_frontend/presentation/theme/palette.dart';

import 'components/appbar.dart';
import 'components/navigation_menu.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 220,
                height: double.infinity,
                child: ColoredBox(
                  color: Color.fromARGB(255, 223, 219, 218),
                  child: NavigationMenu(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ColoredBox(
                      color: Palette.dirtyWhite,
                      child: AutoRouter(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const WebDashboardAppBar(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:esprit_alumni_frontend/presentation/theme/icons.dart';
import 'package:esprit_alumni_frontend/presentation/theme/palette.dart';

class WebDashboardAppBar extends StatelessWidget {
  const WebDashboardAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                const SizedBox(width: 47),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.asset('assets/images/logo_dashboard.png',
                      height: 70),
                ),
                const Spacer(),
                //const _BellIcon(hasNotifications: true),
                const SizedBox(width: 34),
                const SizedBox(
                  height: 60,
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    backgroundImage:
                        AssetImage('assets/images/avatar_admin.png'),
                    radius: 23,
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
          ),
          const Divider(
            color: Palette.lightGrey10,
            thickness: 1,
            height: 1,
          ),
        ],
      ),
    );
  }
}

class _BellIcon extends StatelessWidget {
  const _BellIcon({required this.hasNotifications, Key? key}) : super(key: key);

  final bool hasNotifications;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        SvgPicture.asset(
          SvgIcons.bell,
          color: Palette.black,
          width: 24,
          height: 27.79,
        ),
        if (hasNotifications)
          Container(
            margin: const EdgeInsets.all(1),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 246, 113, 83),
              shape: BoxShape.circle,
              border: Border.all(color: Palette.dirtyWhite),
            ),
          ),
      ],
    );
  }
}

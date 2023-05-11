import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:esprit_alumni_frontend/presentation/routes/app_router.dart';

import 'package:esprit_alumni_frontend/presentation/theme/palette.dart';
import 'package:esprit_alumni_frontend/presentation/theme/text_styles.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  bool _isListenerAdded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isListenerAdded) {
      AutoRouterDelegate.of(context).addListener(() {
        if (mounted) setState(() {});
      });
      _isListenerAdded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentUrl = AutoRouterDelegate.of(context).urlState.path;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, //DashboardRoute
      children: <Widget>[
        const SizedBox(height: 120),
        _MenuItem(
          iconPath: Icons.dashboard,
          isSelected: currentUrl == '/${const DashboardRoute().path}',
          onTap: () {
            context.navigateTo(
              const MainRoute(children: [DashboardRoute()]),
            );
          },
          text: 'Dashboard',
        ),
        _MenuItem(
          iconPath: Icons.info,
          isSelected: currentUrl == '/${const HomePageRoute().path}',
          onTap: () {
            context.navigateTo(
              const MainRoute(children: [HomePageRoute()]),
            );
          },
          text: 'About Us',
        ),
        _MenuItem(
          iconPath: Icons.install_mobile,
          isSelected:
              currentUrl == '/${const UserLoyaltyAndRewardsRoute().path}',
          onTap: () {
            context.navigateTo(
              const MainRoute(children: [UserLoyaltyAndRewardsRoute()]),
            );
          },
          text: 'Download Our App',
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.iconPath,
    required this.text,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final IconData iconPath;

  final String text;

  final void Function() onTap;

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 205,
          height: 42,
          margin: const EdgeInsets.only(bottom: 25),
          decoration: isSelected
              ? const BoxDecoration(
                  color: Color.fromRGBO(255, 60, 5, 5),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                )
              : null,
          child: Padding(
            padding: const EdgeInsets.only(left: 43.0),
            child: Row(
              children: <Widget>[
                Icon(
                  iconPath,
                  size: 20,
                  color: isSelected
                      ? Palette.dirtyWhite
                      : Color.fromARGB(255, 65, 0, 0).withOpacity(0.8),
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: isSelected
                      ? TextStyles.myriadProSemiBold12DirtyWhite
                      : TextStyles.myriadProSemiBold12DirtyWhite.copyWith(
                          color: Color.fromARGB(255, 65, 0, 0).withOpacity(0.8),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:esprit_alumni_frontend/presentation/page/dashboard_page/components/statistics_box/components/civil.dart';
import 'package:esprit_alumni_frontend/presentation/page/dashboard_page/components/statistics_box/components/computer_science.dart';
import 'package:esprit_alumni_frontend/presentation/page/dashboard_page/components/statistics_box/components/electro.dart';
import 'package:esprit_alumni_frontend/presentation/page/dashboard_page/components/statistics_box/components/telecom.dart';
import 'package:esprit_alumni_frontend/presentation/theme/palette.dart';
import 'package:esprit_alumni_frontend/presentation/theme/text_styles.dart';
import 'package:flutter/material.dart';

class Specialties extends StatefulWidget {
  const Specialties({Key? key}) : super(key: key);

  @override
  State<Specialties> createState() => _SpecialtiesState();
}

class _SpecialtiesState extends State<Specialties> {
  final PageController _controller = PageController(initialPage: 1);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 650,
      height: 430,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 32.0, left: 32.0),
            child: Text(
              'Specialties Taught At Esprit',
              style: TextStyles.myriadProSemiBold22DarkBlue,
            ),
          ),
          const SizedBox(height: 26),
          _StatisticsTabs(pageController: _controller),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: const <Widget>[
                ComputerScience(),
                Telecommunications(),
                CivilEngineering(),
                Electromechanics(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatisticsTabs extends StatefulWidget {
  const _StatisticsTabs({required this.pageController, Key? key})
      : super(key: key);

  final PageController pageController;

  @override
  _StatisticsTabsState createState() => _StatisticsTabsState();
}

class _StatisticsTabsState extends State<_StatisticsTabs>
    with TickerProviderStateMixin {
  late final TabController _controller;

  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 4,
      vsync: this,
      initialIndex: selectedIndex,
    );
    _controller.addListener(() {
      widget.pageController.jumpToPage(_controller.index);
      setState(() {
        selectedIndex = _controller.index;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.bottomCenter,
            child: Divider(color: Palette.lightGrey),
          ),
          TabBar(
            padding: const EdgeInsets.only(left: 20),
            isScrollable: true,
            controller: _controller,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              _StatisticsTab(
                  isSelected: selectedIndex == 0, text: 'Computer Science'),
              _StatisticsTab(
                isSelected: selectedIndex == 1,
                text: 'Telecommunications',
              ),
              _StatisticsTab(
                  isSelected: selectedIndex == 2, text: 'Civil Engineering'),
              _StatisticsTab(
                  isSelected: selectedIndex == 3, text: 'Electromechanics'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatisticsTab extends StatelessWidget {
  const _StatisticsTab({required this.text, required this.isSelected, Key? key})
      : super(key: key);

  final bool isSelected;

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Text(
        text,
        style: isSelected
            ? TextStyles.myriadProSemiBold14LightBlue
            : TextStyles.myriadProSemiBold14DarkBlue.copyWith(
                color: Color.fromARGB(255, 185, 10, 10),
              ),
      ),
    );
  }
}

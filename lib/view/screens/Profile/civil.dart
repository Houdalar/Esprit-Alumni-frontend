import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Civil extends StatefulWidget {
  const Civil({super.key});

  @override
  State<Civil> createState() => _CivilState();
}

class _CivilState extends State<Civil> {
  bool _isExpanded = false;
  final List<Item> _items = <Item>[
    Item(
      headerValue: '   O And G',
      expandedValue:
          '►► Oil And Gas Engineering\n\n• This option aims to equip graduates with the essential knowledge to pursue a career as an entry-level engineer in the oil and gas industry or continue with advanced studies such as a Master'
          's or Ph.D. in Petroleum Engineering\n\n• This option covers three (3) fundamental courses that span the petroleum engineering spectrum from upstream perspectives: \n\n• Reservoir engineering\n\n• Production engineering\n\n• Drilling engineering.\n\n• Students will have the opportunity to contribute to real engineering team projects that are relevant to the petroleum industry.',
    ),
    Item(
      headerValue: '   Structures and\n   Works',
      expandedValue:
          '►► Structures and Works\n\n• Structures and Works is an engineering option that focuses on the design, construction, and maintenance of various civil engineering structures and infrastructure projects such as buildings, bridges, tunnels, dams, roads, and airports\n\n• The option provides students with a solid foundation in structural analysis, materials science, geotechnical engineering, and construction management\n\n• It also emphasizes the application of computer-aided design and simulation tools to develop efficient and innovative structural solutions\n\n• Graduates of this option are well-equipped to work in the construction industry, either in design, management or supervision of various infrastructure projects.',
    ),
    Item(
      headerValue: '   Eco-Construction &\n   Energy Efficiency',
      expandedValue:
          '►► Eco-Construction and Energy Efficiency\n\n• This option aims to deepen the training of GC engineers at ESPRIT and complement their skills in order to pursue a career related to eco-construction, sustainable development, and energy efficiency.\n\n• It also aims to train versatile engineers capable of designing, managing, and organizing ecological buildings, as well as optimizing energy consumption in buildings.',
    ),
    Item(
      headerValue: '   Bridges and Roads',
      expandedValue:
          '►► Bridges and Roads\n\n• The optional course "Bridges and Roads" is intended for 4th year Civil Engineering students who wish to deepen their knowledge in the field of structures and roads in order to facilitate their integration into organizations and design offices responsible for infrastructure design and studies.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Civil Engineering',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mukta Malar'),
                  ),
                ],
              ),
              Image.asset(
                'media/civil.png',
                width: MediaQuery.of(context).size.width / 1.17,
                height: MediaQuery.of(context).size.height / 2.9,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildContainerXL(
                      Icons.construction_outlined,
                      'Civil Engineering',
                      'Work on designing new structures, assessing the safety and stability of existing structures, and developing plans to manage environmental risks.',
                    ),
                    const SizedBox(height: 25.0),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.17,
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
                child: Column(
                  children: [
                    const SizedBox(height: 15.0),
                    const Text(
                      'Options',
                      style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Mukta Malar',
                          color: Color.fromARGB(255, 178, 0, 0)),
                    ),
                    const SizedBox(height: 25.0),
                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _items[index].isExpanded = !isExpanded;
                        });
                      },
                      children: _items.map<ExpansionPanel>((Item item) {
                        return ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              //leading: Icon(Icons.arrow_right),
                              title: Text(item.headerValue,
                                  style: const TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Mukta Malar',
                                      color:
                                          Color.fromARGB(255, 155, 149, 149))),
                            );
                          },
                          body: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0,
                                  left: 12.0,
                                  right: 12.0,
                                  bottom: 12.0),
                              child: Text(item.expandedValue,
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Mukta Malar')),
                            ),
                          ),
                          isExpanded: item.isExpanded,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainerXL(IconData iconData, String title, String text) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.17,
      height: MediaQuery.of(context).size.height / 3.3,
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
                      fontSize: 22,
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
                  fontSize: 20,
                  fontFamily: 'Mukta Malar',
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

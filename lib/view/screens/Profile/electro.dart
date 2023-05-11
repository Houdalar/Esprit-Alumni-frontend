import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Electromechanics extends StatefulWidget {
  const Electromechanics({super.key});

  @override
  State<Electromechanics> createState() => _ElectromechanicsState();
}

class _ElectromechanicsState extends State<Electromechanics> {
  bool _isExpanded = false;
  final List<Item> _items = <Item>[
    Item(
      headerValue: '   OGI',
      expandedValue:
          '►► Organization and Industrial Management\n\n• The objective of creating the OGI option is to complement and perfect the training of Esprit'
          's Electromechanical Engineers who wish to have a career related to optimizing performance indicators (KPIs) of a complete logistics chain\n\n• The OGI option focuses on the design and implementation of industrial management systems\n\n• It covers topics such as supply chain management, production planning and control, inventory management, quality management, and lean manufacturing.',
    ),
    Item(
      headerValue: '   Mecha​​tronics',
      expandedValue:
          '►► Mecha​​tronics\n\n• Mechatronics is an industrial approach that closely combines mechanics, electronics, automation, and real-time computing for the design and manufacturing of new complex automatic systems\n\n• The training provided by the Mechatronics option to engineering students in Electromechanics offers a solid foundation of fundamental knowledge, broadening their knowledge through the various facets of this multidisciplinary field and weaving links between these different aspects\n\n• Through this option, students will learn how to design and develop intelligent machines, smart systems, and automated processes that can adapt and respond to their environment in real-time.',
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
                    'Electromechanics',
                    style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mukta Malar'),
                  ),
                ],
              ),
              Image.asset(
                'media/electro.png',
                width: MediaQuery.of(context).size.width / 1.17,
                height: MediaQuery.of(context).size.height / 2.9,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildContainerXL(
                      Icons.miscellaneous_services,
                      'Electromechanics',
                      'Work on designing control systems for machines and robots to developing renewable energy systems.',
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
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Mukta Malar',
                                      color:
                                          Color.fromARGB(255, 122, 120, 120))),
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
      height: MediaQuery.of(context).size.height / 3.7,
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

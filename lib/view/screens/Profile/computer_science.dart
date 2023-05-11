import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ComputerScience extends StatefulWidget {
  const ComputerScience({super.key});

  @override
  State<ComputerScience> createState() => _ComputerScienceState();
}

class _ComputerScienceState extends State<ComputerScience> {
  bool _isExpanded = false;
  final List<Item> _items = <Item>[
    Item(
      headerValue: '   SIM',
      expandedValue:
          '►► Computer and Mobile Systems\n\n• This option allows for the training of computer engineers specialized in mobile application development on the Android and iOS operating systems.\n\n• Through this option, students can explore the full lifecycle of mobile app development, from ideation and design to coding, testing, and deployment.\n\n• They can also learn about the latest trends and best practices in mobile app development, such as integrating cloud-based services, using artificial intelligence and machine learning, and implementing responsive design for multiple devices.',
    ),
    Item(
      headerValue: '   TWIN',
      expandedValue:
          '►► Web and Internet Technologies\n\n• The objective of the TWIN option is to direct the training of future engineers towards careers in web and internet technologies by strengthening their skills in the following areas:\n\n• Developing advanced skills in the most widely used web development languages in the job market\n\n• Deepening their knowledge of development environments, frameworks, and best practices in web development\n\n• Utilizing techniques related to user experience (UX) and responsive design\n\n• Mastering web site optimization techniques for search engine ranking\n\n• Mastering techniques for analyzing web data, including web analytics, data mining, and big data.',
    ),
    Item(
      headerValue: '   DS',
      expandedValue:
          '►► Data Science\n\n• The objective of the Data Science option is to acquire a foundational knowledge base leading to the operational practice of the "data scientist" profession.\n\nAdditionally, the goals of the DS option include:\n\n• Having a strong understanding of statistical data processing\n\n• Becoming familiar with the fundamental aspects of Big Data\n\n• Mastering methods and tools for Artificial Intelligence (AI).',
    ),
    Item(
      headerValue: '   Infini',
      expandedValue:
          '►► Financial Computing and Engineering\n\n• This option will allow students to apply computer and mathematical tools in the field of finance and insurance.\n\n• Students will learn about the principles of finance, including financial markets, investment analysis, and risk management\n\n• They will also develop advanced skills in programming, data analysis, and mathematical modeling\n\n• By combining these skills, students will be able to develop and implement computational methods for financial analysis and decision-making.',
    ),
    Item(
      headerValue: '   SAE',
      expandedValue:
          '►► Software Architecture Engineering\n\n• The Software Architecture Engineering option (formerly known as GL) is the path towards becoming a versatile engineer\n\n• It provides targeted training in complementary areas, including software development, quality, software architecture, data acquisition, testing and validation, systems, and networks\n\n• This option is dedicated to those who are looking to succeed in a career as an information systems architect, project manager, IT consultant, developer, or even as a specialist in systems and networks.',
    ),
    Item(
      headerValue: '   ERP-BI',
      expandedValue:
          '►► Enterprise Resource Planning-Business Intelligence\n\n• The ERP-BI option is a program that allows students to discover a wide variety of tools, applications, and methodologies used in the field of data analysis for businesses\n\n• Enterprises use ERP (Enterprise Resource Planning) systems to collect data on business operations and processes\n\n• Students will learn how to use this data to set up analyses and reports that enable decision-makers to make informed decisions\n\n• They will also learn how to use BI (Business Intelligence) tools to analyze data and create reports that can be used to make strategic decisions.',
    ),
    Item(
      headerValue: '   SLEAM',
      expandedValue:
          '►► Embedded Ambient and Mobile Systems and Software\n\n• Expertise in the fields of embedded computing, information systems engineering, connected objects, and mobile applications is necessary for the design, specification, and prototyping of new embedded, ambient, and mobile services\n\n• This option provides a versatile education, with strong multidisciplinary skills in the area of the Internet of Things.',
    ),
    Item(
      headerValue: '   NIDS',
      expandedValue:
          '►► Network Infrastructure And Data Security\n\n• This option allows students to study computer system vulnerabilities, design, and deploy security solutions based on the latest technologies and regulations\n\n• The option provides students with the knowledge and skills to identify potential security threats and vulnerabilities in computer systems\n\n• They will also learn how to implement the latest security technologies and solutions to protect against these threats\n\n• This option will prepare students for careers in cybersecurity, including positions such as security analysts, security architects, and security consultants.',
    ),
    Item(
      headerValue: '   SE',
      expandedValue:
          '►► Software Engineering\n\n• The Software Engineering SE (formerly known as InfoB) option aims to train engineers capable of analyzing, designing, developing, and testing very large-scale computer systems, as well as exploiting innovative and intelligent solutions in the field of software engineering\n\n• This option keeps up with the latest technologies and cutting-edge application domains\n\n• In this option, students will learn how to apply best practices and software engineering methodologies to develop high-quality software systems\n\n• They will also gain knowledge in software architecture, project management, quality assurance, and testing.',
    ),
    Item(
      headerValue: '   ArcTIC',
      expandedValue:
          '►► IT Architecture and Cloud Computing\n\n• The IT Architecture and Cloud Computing (ArcTIC) option is a training program for engineering students aimed at producing engineers who can:\n\n• Identify the needs of businesses for dematerialized infrastructures\n\n• Design information system architectures for businesses\n\n• Ensure the implementation of applications and data storage solutions on servers installed in data centers and their integration into the company'
          's system architecture\n\n• The option focuses on providing students with the necessary knowledge and skills to work with cloud technologies and to design, deploy and manage cloud-based infrastructure solutions for businesses\n\n• Students will also gain knowledge on cloud computing models, service-level agreements, and security issues related to cloud computing.',
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
                    'Computer Science',
                    style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mukta Malar'),
                  ),
                ],
              ),
              Image.asset(
                'media/computer_sc.png',
                width: MediaQuery.of(context).size.width / 1.17,
                height: MediaQuery.of(context).size.height / 2.9,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildContainerXL(
                      Icons.computer,
                      'COMPUTER SCIENCE',
                      'Mastery of software engineering techniques (methods, languages & tools) and user interaction for the design of embedded software and information systems. Acquisition of skills in the design and deployment of systems and networks at the software/hardware interface. The computer science specialty is divided into a first common core cycle with the telecommunications specialty, and a second cycle consisting of different paths that represent options.',
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
      height: MediaQuery.of(context).size.height / 1.6,
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

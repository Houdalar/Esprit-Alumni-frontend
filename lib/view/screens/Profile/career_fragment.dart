import 'package:flutter/material.dart';
import 'package:esprit_alumni_frontend/viewmodel/profileViewModel.dart';
import 'education_screen.dart';
import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CareerFragment extends StatefulWidget {
  String? summary;
  String? status;
  String? education;
  List<String> skills;
  bool isCurrentUser;

  CareerFragment(this.summary, this.status, this.education, this.skills,
      this.isCurrentUser,
      {Key? key})
      : super(key: key);

  @override
  State<CareerFragment> createState() => _CareerFragmentState();
}

class _CareerFragmentState extends State<CareerFragment> {
  String _textSummary = '';
  String _textStatus = '';
  String? token = "";
  late SharedPreferences _prefs;
  List<String> skills_list = [];

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      token = _prefs.getString('userId') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

// SUMMARY EDIT DIALOG ---------------------------------------------------
  void _showEditDialogSummary() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text('Edit your summary'),
          content: TextField(
            controller: TextEditingController(text: widget.summary),
            decoration: const InputDecoration(),
            onChanged: (value) {
              setState(() {
                _textSummary = value;
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'SAVE',
                style: TextStyle(
                  color: Color.fromARGB(255, 177, 5, 5),
                  fontSize: 18.0,
                  fontFamily: 'Mukata Malar',
                ),
              ),
              onPressed: () async {
                await ProfileViewModel.updateSummary(token!, _textSummary);
                setState(() {
                  widget.summary = _textSummary;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // STATUS EDIT DIALOG ----------------------------------------------------------
  void _showEditDialogStatus() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text('Edit your status'),
          content: TextField(
            controller: TextEditingController(text: widget.status),
            decoration: const InputDecoration(),
            onChanged: (value) {
              setState(() {
                _textStatus = value;
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'SAVE',
                style: TextStyle(
                  color: Color.fromARGB(255, 177, 5, 5),
                  fontSize: 18.0,
                  fontFamily: 'Mukata Malar',
                ),
              ),
              onPressed: () async {
                await ProfileViewModel.updateStatus(token!, _textStatus);
                setState(() {
                  widget.status = _textStatus;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // SKILLS EDIT DIALOG ---------------------------------------------------------------
  void _showDialogSkills(BuildContext context) {
    String newSkill = '';
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new skill'),
          content: TextField(
            controller: controller,
            onChanged: (value) {
              newSkill = value;
            },
            decoration: const InputDecoration(hintText: '#skill'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'SAVE',
                style: TextStyle(
                  color: Color.fromARGB(255, 177, 5, 5),
                  fontSize: 18.0,
                  fontFamily: 'Mukata Malar',
                ),
              ),
              onPressed: () {
                if (newSkill.isNotEmpty) {
                  ProfileViewModel.updateSkills(token!, newSkill);
                  setState(() {
                    skills_list.add(newSkill);
                    newSkill = '';
                  });
                  controller.clear();
                }
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Summary statement',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Mukta Malar',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 90),
                Visibility(
                  visible: widget.isCurrentUser,
                  child: GestureDetector(
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.primaryDark,
                        size: 22,
                      ),
                      onPressed: _showEditDialogSummary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                widget.summary.toString(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Row(
              children: [
                const Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Mukta Malar',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 214),
                Visibility(
                  visible: widget.isCurrentUser,
                  child: GestureDetector(
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.primaryDark,
                        size: 22,
                      ),
                      onPressed: _showEditDialogStatus,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                widget.status.toString(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Education',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Mukta Malar',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 182),
                Visibility(
                  visible: widget.isCurrentUser &&
                      widget.education.toString().isNotEmpty,
                  child: GestureDetector(
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.primaryDark,
                        size: 22,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EducationScreen()),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Wrap(
              children: [
                Image.asset(
                  'media/esprit_logo.png',
                  height: 80,
                  width: 110,
                ),
                const SizedBox(width: 5),
                FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Text(
                    'Ecole supérieur privée d\'ingénierie et de technologie',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Wrap(
              children: [
                Image.asset(
                  'media/other_university.png',
                  height: 80,
                  width: 110,
                ),
                const SizedBox(width: 5),
                // show the button
                FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Stack(children: [
                    Visibility(
                      visible: widget.education.toString().isEmpty,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.grey[800],
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          label: Text(
                            'Add Education',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 12,
                              fontFamily: 'Mukta Malar',
                            ),
                          ),
                          icon: Icon(
                            Icons.add,
                            color: Colors.grey[800],
                            size: 15,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EducationScreen()),
                            ).then((value) {
                              setState(() {});
                            });
                          }),
                    ),
                    const SizedBox(width: 5),
                    Visibility(
                      visible: widget.education.toString().isNotEmpty,
                      child: Text(
                        //_education,
                        widget.education.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Row(
              children: [
                const Text(
                  'Skills',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Mukta Malar',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 223),
                Visibility(
                  visible: widget.isCurrentUser,
                  child: GestureDetector(
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.primaryDark,
                        size: 22,
                      ),
                      onPressed: () {
                        _showDialogSkills(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 0),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: ListView.builder(
                      itemCount: widget.skills.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 30,
                          child: Text(
                            //'# ${skills_list[index]}',
                            '# ${widget.skills[index].toString()}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 163, 18, 8),
                              fontSize: 17.0,
                              fontFamily: 'Mukta Malar',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      })),
            ),
          ],
        ),
      ),
    );
  }
}

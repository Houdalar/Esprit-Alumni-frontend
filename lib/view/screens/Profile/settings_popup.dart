import 'package:flutter/material.dart';

class SettingsPopup extends StatelessWidget {
  const SettingsPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Settings'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Edit Credentials'),
              onTap: () {
                // TODO: Add functionality for editing profile
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // TODO: Add functionality for logging out
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
              onTap: () {
                // TODO: Add functionality for displaying privacy policy
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                // TODO: Add functionality for displaying information about the app or company
              },
            ),
          ],
        ),
      ),
    );
  }
}

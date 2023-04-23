import 'package:flutter/material.dart';

class SettingsPopup extends StatelessWidget {
  const SettingsPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Settings'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Credentials'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy Policy'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:esprit_alumni_frontend/viewmodel/settings/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends GetView<SettingsController> {
  const Settings({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 22,
                    color: AppColors.primaryDark,
                  ),
                ),
                backgroundColor: AppColors.lightGray,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: SettingsList(
                        applicationType: ApplicationType.both,
                        sections: [
                          SettingsSection(
                            title: Text(
                              "Account",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 13.5),
                            ),
                            tiles: [
                              SettingsTile.navigation(
                                leading: const Icon(
                                  Icons.edit,
                                  color: AppColors.redColor,
                                ),
                                title: const Text(
                                  'Change username',
                                  style: TextStyle(fontSize: 17),
                                ),
                                onPressed: (context) {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        _buildChangeUsernameDialog(
                                            context, controller),
                                  );
                                },
                              ),
                              SettingsTile.navigation(
                                leading: const Icon(
                                  Icons.key,
                                  color: AppColors.redColor,
                                ),
                                title: const Text(
                                  'Change password',
                                  style: TextStyle(fontSize: 17),
                                ),
                                onPressed: (context) {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          _buildChangePasswordDialog(
                                              context, controller));
                                },
                              ),
                            ],
                          ),
                          // SettingsSection(
                          //   title: Text(
                          //     "Notifications",
                          //     style: TextStyle(color: Colors.grey[600], fontSize: 13.5),
                          //   ),
                          //   tiles: [
                          //     SettingsTile.switchTile(
                          //       onToggle: (value) {},
                          //       initialValue: true,
                          //       leading: const Icon(Icons.notifications,
                          //           color: AppColors.redColor),
                          //       title: const Text(
                          //         'Enable notifications',
                          //         style: TextStyle(fontSize: 17),
                          //       ),
                          //       activeSwitchColor: AppColors.redColor,
                          //     ),
                          //   ],
                          // ),
                          SettingsSection(
                            title: Text(
                              "Privacy Policy",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 13.5),
                            ),
                            tiles: [
                              SettingsTile.navigation(
                                leading: Image.asset(
                                  "assets/images/privacy-policy.png",
                                  width: 23,
                                  height: 23,
                                ),
                                title: const Text(
                                  'Privacy Policy and Terms of use',
                                  style: TextStyle(fontSize: 17),
                                ),
                                onPressed: (context) {},
                              ),
                            ],
                          ),
                          SettingsSection(
                            title: Text(
                              "Session management",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 13.5),
                            ),
                            tiles: [
                              SettingsTile.navigation(
                                leading: const Icon(
                                  Icons.logout,
                                  color: AppColors.redColor,
                                ),
                                title: const Text(
                                  'Sign out',
                                  style: TextStyle(fontSize: 17),
                                ),
                                onPressed: (context) async {
                                  _showSignOutDialog(context);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  Widget _buildChangePasswordDialog(
      BuildContext context, SettingsController controller) {
    final formKey = GlobalKey<FormState>();
    String currentPassword = '';
    String newPassword = '';

    void _submitForm() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = prefs.getString('id') ?? '';

      log('User ID: $id');

      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        try {
          await controller.updatePassword(id, currentPassword, newPassword);
          Navigator.of(context).pop();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      }
    }

    return AlertDialog(
      title: const Text('Change Password'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Current Password'),
              obscureText: true,
              onSaved: (value) => currentPassword = value!,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter the current password' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'New Password'),
              obscureText: true,
              onSaved: (value) => newPassword = value!,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a new password' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.black),
          ),
        ),
        TextButton(
          onPressed: _submitForm,
          child: const Text(
            'Save',
            style: TextStyle(color: AppColors.redColor),
          ),
        ),
      ],
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Do you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: AppColors.black),
              ),
            ),
            TextButton(
              onPressed: () async {
                await _signOut(context);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: AppColors.redColor),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed('/login');
    // Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  Widget _buildChangeUsernameDialog(
      BuildContext context, SettingsController controller) {
    final formKey = GlobalKey<FormState>();
    String newUsername = '';

    void _submitForm() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('userId') ?? '';

      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        try {
          await controller.updateUsername(newUsername, token);
          Navigator.of(context).pop();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      }
    }

    return AlertDialog(
      title: const Text('Change Username'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'New Username'),
              onSaved: (value) => newUsername = value!,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a new username' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.black),
          ),
        ),
        TextButton(
          onPressed: _submitForm,
          child: const Text(
            'Save',
            style: TextStyle(color: AppColors.redColor),
          ),
        ),
      ],
    );
  }
}

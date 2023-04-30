import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:esprit_alumni_frontend/viewmodel/settings/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends GetView<SettingsController> {
  const Settings({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Settings",
            style: TextStyle(fontSize: 23),
          ),
          centerTitle: true,
          backgroundColor: AppColors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.gradientColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SettingsList(
              applicationType: ApplicationType.both,
              sections: [
                SettingsSection(
                  title: Text(
                    "Account",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13.5),
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
                      onPressed: (context) {},
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
                      onPressed: (context) {},
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text(
                    "Notifications",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13.5),
                  ),
                  tiles: [
                    SettingsTile.switchTile(
                      onToggle: (value) {},
                      initialValue: true,
                      leading: const Icon(Icons.notifications,
                          color: AppColors.redColor),
                      title: const Text(
                        'Enable notifications',
                        style: TextStyle(fontSize: 17),
                      ),
                      activeSwitchColor: AppColors.redColor,
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text(
                    "Privacy Policy",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13.5),
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
                    style: TextStyle(color: Colors.grey[600], fontSize: 13.5),
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
                      onPressed: (context) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

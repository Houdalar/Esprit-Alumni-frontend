import 'dart:developer';

import 'package:esprit_alumni_frontend/viewmodel/settings/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  updatePassword(String id, String curentpassword, String newpassword) async {
    await SettingsService.updatePassword(id, curentpassword, newpassword)
        .then(
            (value) => Get.snackbar("Success", "Password updated successfully",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                )))
        .catchError((onError) => {
              log(onError.toString()),
              Get.snackbar("Error", "Failed to update password",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  icon: const Icon(
                    Icons.error,
                    color: Colors.white,
                  ))
            });
  }

  updateUsername(String username, String token) async {
    await SettingsService.updateUsername(username, token)
        .then(
            (value) => Get.snackbar("Success", "Username updated successfully",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                )))
        .catchError((onError) => {
              log(onError.toString()),
              Get.snackbar("Error", "Failed to update username",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  icon: const Icon(
                    Icons.error,
                    color: Colors.white,
                  ))
            });
  }
}

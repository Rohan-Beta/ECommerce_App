// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/users/authentication/login_screen.dart';
import 'package:ecommerce/users/userSharedPreferences/user_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignOut {
  signOutUser() async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: Text("Logout"),
        content: Text("Are you sure , you want to Logout from the app?"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "No",
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: "LoggedOut");
            },
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
    if (resultResponse == "LoggedOut") {
      // delete user data from local storage
      RememberUserPrefs.removeUserInfo().then(
        (value) => {
          Get.off(LogInScreen()),
        },
      );
    }
  }
}

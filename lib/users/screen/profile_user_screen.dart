// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/users/authentication/login_screen.dart';
import 'package:ecommerce/users/userSharedPreferences/current_user.dart';
import 'package:ecommerce/users/userSharedPreferences/user_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilUserScreen extends StatelessWidget {
  ProfilUserScreen({super.key});

  final CurrentUser _currentUser = Get.put(CurrentUser());

  Widget userInfoProfile(IconData iconData, String userData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 30,
              color: Colors.black,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              userData,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Image.asset(
                "MyAssets/imagess/man.png",
                width: 240,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            userInfoProfile(Icons.person, _currentUser.user.user_name),
            userInfoProfile(Icons.email, _currentUser.user.user_email),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                child: const Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  signOutUser();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

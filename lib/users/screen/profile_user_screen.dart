// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/backend/sign_out.dart';
import 'package:ecommerce/backend/user_info.dart';
import 'package:ecommerce/users/userSharedPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilUserScreen extends StatelessWidget {
  ProfilUserScreen({super.key});

  final CurrentUser _currentUser = Get.put(CurrentUser());

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
            UserInfoBar()
                .userInfoProfile(Icons.person, _currentUser.user.user_name),
            UserInfoBar()
                .userInfoProfile(Icons.email, _currentUser.user.user_email),
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
                  SignOut().signOutUser();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

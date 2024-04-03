// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class UserInfoBar {
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
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProfileFragmentScreen extends StatelessWidget {
  const ProfileFragmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: Center(
            child: Text("Profile Fragment Screen"),
          ),
        ),
      ),
    );
  }
}

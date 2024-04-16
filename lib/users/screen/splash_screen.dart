// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:ecommerce/users/screen/dashboard_screen.dart';
import 'package:ecommerce/utilss/next_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final DashboardScreen dashboardScreen;
  const SplashScreen({super.key, required this.dashboardScreen});

  @override
  State<SplashScreen> createState() => SsplashScreenState();
}

class SsplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 2),
      () {
        nextScreenReplace(context, widget.dashboardScreen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage("MyAssets/imagess/splash.png"),
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}

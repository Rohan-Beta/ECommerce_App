// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/users/authentication/login_screen.dart';
import 'package:ecommerce/users/screen/dashboard_screen.dart';
import 'package:ecommerce/users/screen/splash_screen.dart';
import 'package:ecommerce/users/userSharedPreferences/user_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce Store',
      home: Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            future: RememberUserPrefs.readUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return LogInScreen();
              } else {
                return SplashScreen(dashboardScreen: DashboardScreen());
              }
            },
          ),
        ),
      ),
    );
  }
}

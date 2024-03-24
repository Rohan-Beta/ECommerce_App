// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/users/authentication/login_screen.dart';
import 'package:ecommerce/users/fragments_screen/dashboard_of_fragments_screen.dart';
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
      // theme: ThemeData(
      //   primarySwatch: Colors.purple,
      //   useMaterial3: true,
      // ),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            builder: (context, snapshot) {
              // return LogInScreen();
              return DashboardOfFragmentsScreen();
            },
            future: Future.delayed(
              Duration(seconds: 1),
            ),
          ),
        ),
      ),
    );
  }
}

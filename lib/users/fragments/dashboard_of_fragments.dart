// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DashboardOfFragments extends StatelessWidget {
  const DashboardOfFragments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}

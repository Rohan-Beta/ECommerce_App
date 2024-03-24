// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class OrderFragmentScreen extends StatelessWidget {
  const OrderFragmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: Center(
            child: Text("Order Fragment Screen"),
          ),
        ),
      ),
    );
  }
}

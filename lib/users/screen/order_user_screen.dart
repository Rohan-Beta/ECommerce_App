// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class OrderUserScreen extends StatelessWidget {
  const OrderUserScreen({super.key});

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

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AdminUploadItemsScreen extends StatefulWidget {
  const AdminUploadItemsScreen({super.key});

  @override
  State<AdminUploadItemsScreen> createState() => _AdminUploadItemsState();
}

class _AdminUploadItemsState extends State<AdminUploadItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Admin Page"),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextForm {
  TextFormField myText(TextEditingController controller, String hintText,
      String returnText, IconData myIcon) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return returnText;
        }
        return null;
      },
      decoration: InputDecoration(
        icon: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            myIcon,
            color: Colors.black,
          ),
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.white60,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 6,
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}

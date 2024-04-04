// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';

class AddToCartWidget {
  Widget AddToCartButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Material(
        elevation: 4,
        color: Colors.purpleAccent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(10),
          child: Container(
            alignment: Alignment.center,
            height: 50,
            child: Text(
              "Add To Cart",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

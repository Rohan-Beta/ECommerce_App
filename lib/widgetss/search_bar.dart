// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/users/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MYSearchBar {
  Widget searchBarWidget(
      TextEditingController searchController, var onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.search,
              color: Colors.purpleAccent,
            ),
          ),
          hintText: "Looking for something cool...",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
          suffixIcon: IconButton(
            onPressed: () {
              Get.to(CartScreen());
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.purpleAccent,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.purpleAccent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.purpleAccent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.blue,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}

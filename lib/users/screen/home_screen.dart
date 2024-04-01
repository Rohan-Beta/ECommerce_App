// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:ecommerce/modell/cloth_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController searchController = TextEditingController();

  // Future<List<ClothesModel>> getTerndingClothes() async{
  //   // clothItemsData
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              searchBarWidget(),
              SizedBox(height: 26),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "Trending",
                  style: TextStyle(
                    color: Colors.purpleAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 26),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "New Collection",
                  style: TextStyle(
                    color: Colors.purpleAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBarWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.purpleAccent,
            ),
          ),
          hintText: "Looking for something cool...",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
          suffixIcon: IconButton(
            onPressed: () {},
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

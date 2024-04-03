// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print, avoid_function_literals_in_foreach_calls, prefer_is_empty, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/modell/cloth_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController searchController = TextEditingController();

  Future<List<ClothesModel>> getTerndingClothes() async {
    List<ClothesModel> trendingClothItems = [];

    try {
      var res = await http.post(
        Uri.parse(API.trendingClothes),
      );
      if (res.statusCode == 200) {
        var resBodyOfTrendingItems = jsonDecode(res.body);

        if (resBodyOfTrendingItems["success"] == true) {
          (resBodyOfTrendingItems["clothItemsData"] as List)
              .forEach((eachRecord) {
            trendingClothItems.add(ClothesModel.fromJson(eachRecord));
          });
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    return trendingClothItems;
  }

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
              trendingMostPupularItem(context),
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

  Widget trendingMostPupularItem(context) {
    return FutureBuilder(
      future: getTerndingClothes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == null) {
          return Center(
            child: Text("No Trending Item Found"),
          );
        }
        if (snapshot.data!.length > 0) {
          return Container(
            height: 260,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                ClothesModel eachItemData = snapshot.data![index];

                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 200,
                    margin: EdgeInsets.fromLTRB(index == 0 ? 16 : 8, 10,
                        index == snapshot.data!.length - 1 ? 16 : 8, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 6,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: Text("Empty! No Data"),
          );
        }
      },
    );
  }
}

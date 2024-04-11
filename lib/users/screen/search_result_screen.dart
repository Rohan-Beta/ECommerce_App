// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls, avoid_print, prefer_is_empty

import 'dart:convert';

import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/modell/cloth_model.dart';
import 'package:ecommerce/users/screen/item_detail_screen.dart';
import 'package:ecommerce/widgetss/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchResultScreen extends StatefulWidget {
  final String? typedKeyWords;

  const SearchResultScreen({super.key, this.typedKeyWords});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  TextEditingController searchController = TextEditingController();

  Future<List<ClothesModel>> readSearchRecords() async {
    List<ClothesModel> clothsSearchList = [];

    if (searchController.text != "") {
      try {
        var res = await http.post(
          Uri.parse(API.searchItem),
          body: {
            "typedKeyWords": searchController.text.trim(),
          },
        );
        if (res.statusCode == 200) {
          var resBodyOfCurrentUserSearchItems = jsonDecode(res.body);

          if (resBodyOfCurrentUserSearchItems['success'] == true) {
            (resBodyOfCurrentUserSearchItems['searchData'] as List).forEach(
              (eachCurrentUserSearchItem) {
                clothsSearchList
                    .add(ClothesModel.fromJson(eachCurrentUserSearchItem));
              },
            );
          }
        }
      } catch (e) {
        print(e.toString());
      }
    }
    return clothsSearchList;
  }

  @override
  void initState() {
    super.initState();
    searchController.text = widget.typedKeyWords!;
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
              MYSearchBar().searchBarWidget(searchController, () {
                setState(() {});
              }),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: RichText(
                  text: TextSpan(
                    text: "Showing Result For: ",
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: widget.typedKeyWords,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              showSearchItem(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget showSearchItem(context) {
    return FutureBuilder(
      future: readSearchRecords(),
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
          return ListView.builder(
            itemCount: snapshot.data!.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              ClothesModel eachItemData = snapshot.data![index];

              return GestureDetector(
                onTap: () {
                  Get.to(
                    ItemDetailScreen(
                      itemInfo: eachItemData,
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    16,
                    index == 0 ? 16 : 8,
                    16,
                    index == snapshot.data!.length - 1 ? 16 : 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 6,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // name , price , tags
                                  Expanded(
                                    child: Text(
                                      eachItemData.item_name!, // item name
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      "₹${eachItemData.item_price}", // item price
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.purpleAccent,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Text(
                                  eachItemData.item_tags
                                      .toString()
                                      .replaceAll("[", "")
                                      .replaceAll("]", ""), // item tags
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // item image

                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: FadeInImage(
                          height: 130,
                          width: 130,
                          fit: BoxFit.cover,
                          placeholder:
                              AssetImage("MyAssets/imagess/place_holder.png"),
                          image: NetworkImage(
                            eachItemData.item_image!, // product image
                          ),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
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

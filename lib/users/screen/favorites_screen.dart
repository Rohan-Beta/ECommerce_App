// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls, avoid_print, prefer_is_empty

import 'package:ecommerce/backend/favorite_backend.dart';
import 'package:ecommerce/modell/cloth_model.dart';
import 'package:ecommerce/modell/favorite_model.dart';
import 'package:ecommerce/users/screen/item_detail_screen.dart';
import 'package:ecommerce/users/userSharedPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final CurrentUser currentUser = Get.put(CurrentUser());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 8, 8),
                child: Text(
                  "My Favorite List:",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 8, 8),
                child: Text(
                  "Order these items for yourself now:",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(height: 24),
              favoriteItems(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget favoriteItems(context) {
    return FutureBuilder(
      future: FavoriteBackend().getCurrentUserFavoriteList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == null) {
          return Center(
            child: Text(
              "No Favorite Item Found",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        if (snapshot.data!.length > 0) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              FavoriteModel eachFavoriteItemData = snapshot.data![index];

              ClothesModel clickClothItem = ClothesModel(
                item_id: eachFavoriteItemData.item_id,
                item_name: eachFavoriteItemData.item_name,
                item_rating: eachFavoriteItemData.item_rating,
                item_tags: eachFavoriteItemData.item_tags,
                item_price: eachFavoriteItemData.item_price,
                item_sizes: eachFavoriteItemData.item_sizes,
                item_colors: eachFavoriteItemData.item_colors,
                item_description: eachFavoriteItemData.item_description,
                item_image: eachFavoriteItemData.item_image,
              );

              return GestureDetector(
                onTap: () {
                  Get.to(
                    ItemDetailScreen(
                      itemInfo: clickClothItem,
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
                                      eachFavoriteItemData
                                          .item_name!, // item name
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
                                      "₹${eachFavoriteItemData.item_price}", // item price
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
                                  eachFavoriteItemData.item_tags
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
                            eachFavoriteItemData.item_image!, // product image
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

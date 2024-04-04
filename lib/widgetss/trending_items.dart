// ignore_for_file: prefer_const_constructors, prefer_is_empty, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:ecommerce/backend/cloths_items.dart';
import 'package:ecommerce/modell/cloth_model.dart';
import 'package:ecommerce/users/screen/item_detail_screen.dart';
import 'package:ecommerce/utilss/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TrendingItems {
  Widget trendingMostPupularItem(context) {
    return FutureBuilder(
      future: ClothItems().getTerndingClothes(),
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
                  onTap: () {
                    nextScreen(
                        context,
                        ItemDetailScreen(
                          itemInfo: eachItemData,
                        ));
                  },
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
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          ),
                          child: FadeInImage(
                            height: 150,
                            width: 200,
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
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      eachItemData.item_name!, //item name
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    eachItemData.item_price
                                        .toString(), // item price
                                    style: TextStyle(
                                      color: Colors.purpleAccent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // item rating number and stars

                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: eachItemData.item_rating!,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemBuilder: (context, c) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (updateRating) {},
                                    ignoreGestures: true,
                                    unratedColor: Colors.grey,
                                    itemSize: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "(${eachItemData.item_rating})",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
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

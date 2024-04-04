// ignore_for_file: prefer_const_constructors, prefer_is_empty, prefer_const_literals_to_create_immutables

import 'package:ecommerce/backend/cloths_items.dart';
import 'package:ecommerce/modell/cloth_model.dart';
import 'package:ecommerce/users/screen/item_detail_screen.dart';
import 'package:ecommerce/utilss/next_screen.dart';
import 'package:flutter/material.dart';

class MyAllItem {
  Widget allItems(context) {
    return FutureBuilder(
      future: ClothItems().getAllClothes(),
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
                  nextScreen(
                      context,
                      ItemDetailScreen(
                        itemInfo: eachItemData,
                      ));
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

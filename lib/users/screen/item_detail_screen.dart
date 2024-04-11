// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print

import 'package:ecommerce/backend/add_cart_item.dart';
import 'package:ecommerce/backend/favorite_backend.dart';
import 'package:ecommerce/backend/item_details_controller.dart';
import 'package:ecommerce/modell/cloth_model.dart';
import 'package:ecommerce/users/screen/dashboard_screen.dart';
import 'package:ecommerce/users/userSharedPreferences/current_user.dart';
import 'package:ecommerce/utilss/next_screen.dart';
import 'package:ecommerce/utilss/screen_size.dart';
import 'package:ecommerce/widgetss/color_selection_widget.dart';
import 'package:ecommerce/widgetss/item_counter_widget.dart';
import 'package:ecommerce/widgetss/size_selection_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ItemDetailScreen extends StatefulWidget {
  final ClothesModel itemInfo;

  const ItemDetailScreen({super.key, required this.itemInfo});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  final itemDetailsController = Get.put(ItemDetailsController());
  final CurrentUser currentUser = Get.put(CurrentUser());

  @override
  void initState() {
    super.initState();
    FavoriteBackend().validateFavoriteList(widget.itemInfo);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // item image

            FadeInImage(
              height: screenSize.height * 0.5,
              width: screenSize.width,
              fit: BoxFit.cover,
              placeholder: AssetImage("MyAssets/imagess/place_holder.png"),
              image: NetworkImage(
                widget.itemInfo.item_image!, // product image
              ),
              imageErrorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                  ),
                );
              },
            ),
            // item information

            Align(
              alignment: Alignment.bottomCenter,
              child: itemInfoWidget(),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    // back button

                    IconButton(
                      onPressed: () {
                        nextScreen(context, DashboardScreen());
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.purpleAccent,
                      ),
                    ),

                    Spacer(),

                    // favorite button

                    Obx(
                      () => IconButton(
                        onPressed: () {
                          if (itemDetailsController.isFavourite == true) {
                            // delete item from favourite
                            FavoriteBackend()
                                .deleteItemFromFavorite(widget.itemInfo);
                          } else {
                            // add item to favourite
                            FavoriteBackend()
                                .addItemToFavorite(widget.itemInfo);
                          }
                        },
                        icon: Icon(
                          itemDetailsController.isFavourite
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  itemInfoWidget() {
    return Container(
      height: MyScreenSize().getScreenSize().height * 0.6,
      width: MyScreenSize().getScreenSize().width,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -3),
            blurRadius: 6,
            color: Colors.purpleAccent,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                height: 8,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 30),

            // item name

            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                widget.itemInfo.item_name!, //item name
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            // item arting , tags , price

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // rating bar

                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: RatingBar.builder(
                              initialRating: widget.itemInfo.item_rating!,
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
                          ),
                          SizedBox(width: 10),
                          Text(
                            "(${widget.itemInfo.item_rating})",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // tags

                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          widget.itemInfo.item_tags
                              .toString()
                              .replaceAll("[", "")
                              .replaceAll("]", ""),
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      SizedBox(height: 16),

                      // price
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "₹${widget.itemInfo.item_price}",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // item counter

                ItemCount().itemCounter(itemDetailsController),
              ],
            ),
            // item sizes

            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Size:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 10),

            ItemSizeSelection()
                .itemSizeSelect(widget.itemInfo, itemDetailsController),

            SizedBox(height: 10),
            // item colors

            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Color:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 10),

            ItemColorSelection()
                .itemColorSelect(widget.itemInfo, itemDetailsController),

            SizedBox(height: 20),
            // item description

            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Description:",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                widget.itemInfo.item_description!,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            // add to cart button

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Material(
                elevation: 4,
                color: Colors.purpleAccent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    AddCartItem().addItemToCart(widget.itemInfo);
                  },
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
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

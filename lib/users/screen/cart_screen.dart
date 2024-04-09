// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, prefer_is_empty, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/backend/cart_controller.dart';
import 'package:ecommerce/modell/cart_model.dart';
import 'package:ecommerce/modell/cloth_model.dart';
import 'package:ecommerce/users/screen/dashboard_screen.dart';
import 'package:ecommerce/users/userSharedPreferences/current_user.dart';
import 'package:ecommerce/utilss/next_screen.dart';
import 'package:ecommerce/utilss/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CurrentUser currentUser = Get.put(CurrentUser());
  final cartController = CartController();

  getCurrentUserCartList() async {
    List<CartModel> cartListOfCurrentUser = [];

    try {
      var res = await http.post(
        Uri.parse(API.readCartList),
        body: {
          "currentOnlineUserID": currentUser.user.user_id.toString(),
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfCurrentUserCartItems = jsonDecode(res.body);

        if (resBodyOfCurrentUserCartItems['success'] == true) {
          (resBodyOfCurrentUserCartItems['currentUserCartData'] as List)
              .forEach(
            (eachCurrentUserCartItem) {
              cartListOfCurrentUser
                  .add(CartModel.fromJson(eachCurrentUserCartItem));
            },
          );
        } else {
          Fluttertoast.showToast(msg: "Error!");
        }
        cartController.setList(cartListOfCurrentUser);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    calculateTotalAmount();
  }

  calculateTotalAmount() {
    cartController.setTotal(0);

    if (cartController.selectedItems.length > 0) {
      cartController.cartList.forEach(
        (itemInCart) {
          if (cartController.selectedItems.contains(itemInCart.item_id)) {
            double totalAmount = (itemInCart.item_price!) *
                (double.parse(itemInCart.item_quantity.toString()));

            cartController.setTotal(cartController.total + totalAmount);
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserCartList();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.grey,
        leading: IconButton(
            onPressed: () {
              nextScreen(context, DashboardScreen());
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(
          () => cartController.cartList.length > 0
              ? ListView.builder(
                  itemCount: cartController.cartList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    CartModel cartModel = cartController.cartList[index];
                    ClothesModel clothesModel = ClothesModel(
                      item_id: cartModel.item_id,
                      item_name: cartModel.item_name,
                      item_rating: cartModel.item_rating,
                      item_tags: cartModel.item_tags,
                      item_price: cartModel.item_price,
                      item_sizes: cartModel.item_sizes,
                      item_colors: cartModel.item_colors,
                      item_description: cartModel.item_description,
                      item_image: cartModel.item_image,
                    );
                    return SizedBox(
                      width: screenSize.width,
                      child: Row(
                        children: [
                          // check and uncheck box

                          GetBuilder(
                            init: CartController(),
                            builder: (c) {
                              return IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  cartController.selectedItems
                                          .contains(cartModel.item_id)
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: cartController.isSelectedAll
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              );
                            },
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                  0,
                                  index == 0 ? 16 : 8,
                                  16,
                                  index == cartController.cartList.length - 1
                                      ? 16
                                      : 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 6,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // name

                                            Text(
                                              clothesModel.item_name.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 20),

                                            Row(
                                              children: [
                                                // color and size of item

                                                Expanded(
                                                  child: Text(
                                                    "Color:" +
                                                        cartModel.item_color!
                                                            .replaceAll('[', '')
                                                            .replaceAll(
                                                                ']', '') +
                                                        "\n" +
                                                        "Size:" +
                                                        cartModel.item_size!
                                                            .replaceAll('[', '')
                                                            .replaceAll(
                                                                ']', ''),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.white60,
                                                    ),
                                                  ),
                                                ),
                                                // price

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12, right: 12),
                                                  child: Text(
                                                    "₹" +
                                                        clothesModel.item_price
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: Colors.purple,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    "Empty Cart",
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

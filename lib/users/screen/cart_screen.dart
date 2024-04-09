// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, prefer_is_empty, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/backend/cart_controller.dart';
import 'package:ecommerce/backend/cart_total_amount.dart';
import 'package:ecommerce/backend/delete_cart_item.dart';
import 'package:ecommerce/backend/update_cart_items.dart';
import 'package:ecommerce/backend/user_cart_list.dart';
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
  final cartController = Get.put(CartController());

  // updateItemQuantityInCart(int cartId, int newQuantity) async {
  //   try {
  //     var res = await http.post(Uri.parse(API.updateCartItems), body: {
  //       "cart_id": cartId.toString(),
  //       "item_quantity": newQuantity.toString(),
  //     });
  //     if (res.statusCode == 200) {
  //       var resBodyOfNewQuantity = jsonDecode(res.body);

  //       if (resBodyOfNewQuantity["success"] == true) {
  //         CurrentUserCartList().getCurrentUserCartList();
  //       } else {
  //         Fluttertoast.showToast(msg: "Error~");
  //       }
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

  @override
  void initState() {
    super.initState();
    CurrentUserCartList().getCurrentUserCartList();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            nextScreen(context, DashboardScreen());
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        // select all items
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                cartController.setIsSelectedAll();
                cartController.clearAllSelectedItems();

                if (cartController.isSelectedAll) {
                  cartController.cartList.forEach(
                    (eachItem) {
                      cartController.addSelected(eachItem.cart_id!);
                    },
                  );
                }
                CartTotalAmount().calculateTotalAmount();
              },
              icon: Icon(
                cartController.isSelectedAll
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color:
                    cartController.isSelectedAll ? Colors.white : Colors.grey,
              ),
            ),
          ),
          // delete all selected items
          GetBuilder(
            init: CartController(),
            builder: (c) {
              if (cartController.selectedItems.length > 0) {
                return IconButton(
                  onPressed: () {
                    cartController.selectedItems.forEach(
                      (eachSelectedItemId) {
                        DeleteCartItem()
                            .deleteSelectedItemsFromCart(eachSelectedItemId);
                      },
                    );
                  },
                  icon: Icon(
                    Icons.delete_sweep,
                    color: Colors.redAccent,
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
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
                                onPressed: () {
                                  if (cartController.selectedItems
                                      .contains(cartModel.cart_id)) {
                                    cartController
                                        .deleteSelected(cartModel.cart_id!);
                                  } else {
                                    cartController
                                        .addSelected(cartModel.cart_id!);
                                  }

                                  CartTotalAmount().calculateTotalAmount();
                                },
                                icon: Icon(
                                  cartController.selectedItems
                                          .contains(cartModel.cart_id)
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
                                            ),
                                            SizedBox(height: 20),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // - button
                                                IconButton(
                                                  onPressed: () {
                                                    if (cartModel
                                                                .item_quantity! -
                                                            1 >=
                                                        1) {
                                                      UpdateCartItem()
                                                          .updateItemQuantityInCart(
                                                              cartModel
                                                                  .cart_id!,
                                                              cartModel
                                                                      .item_quantity! -
                                                                  1);
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Colors.grey,
                                                    size: 30,
                                                  ),
                                                ),
                                                // quantity of product

                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    cartModel.item_quantity
                                                        .toString(),
                                                    style: TextStyle(
                                                        color:
                                                            Colors.purpleAccent,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),

                                                // + button
                                                IconButton(
                                                  onPressed: () {
                                                    UpdateCartItem()
                                                        .updateItemQuantityInCart(
                                                            cartModel.cart_id!,
                                                            cartModel
                                                                    .item_quantity! +
                                                                1);
                                                  },
                                                  icon: Icon(
                                                    Icons.add_circle_outline,
                                                    color: Colors.grey,
                                                    size: 30,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(22),
                                        bottomRight: Radius.circular(22),
                                      ),
                                      child: FadeInImage(
                                        height: 180,
                                        width: 150,
                                        fit: BoxFit.cover,
                                        placeholder: AssetImage(
                                            "MyAssets/imagess/place_holder.png"),
                                        image: NetworkImage(
                                          cartModel
                                              .item_image!, // product image
                                        ),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
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
      bottomNavigationBar: GetBuilder(
        init: CartController(),
        builder: (c) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -3),
                  color: Colors.white24,
                  blurRadius: 6,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                // total amount

                Text(
                  "Total Amount",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4),

                Obx(
                  () => Text(
                    "₹" + cartController.total.toStringAsFixed(2),
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Material(
                    elevation: 4,
                    color: cartController.selectedItems.length > 0
                        ? Colors.purpleAccent
                        : Colors.white24,
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 100,
                        child: Text(
                          "Order Now",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

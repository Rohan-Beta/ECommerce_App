// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:convert';

import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/backend/cart_controller.dart';
import 'package:ecommerce/backend/cart_total_amount.dart';
import 'package:ecommerce/modell/cart_model.dart';
import 'package:ecommerce/users/userSharedPreferences/current_user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CurrentUserCartList {
  final CurrentUser currentUser = Get.put(CurrentUser());
  final cartController = Get.put(CartController());

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
        }
        cartController.setList(cartListOfCurrentUser);
      }
    } catch (e) {
      print(e.toString());
    }
    // calculateTotalAmount();
    CartTotalAmount().calculateTotalAmount();
  }
}

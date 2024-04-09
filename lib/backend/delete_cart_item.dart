// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/backend/cart_total_amount.dart';
import 'package:ecommerce/backend/user_cart_list.dart';
import 'package:http/http.dart' as http;

class DeleteCartItem {
  deleteSelectedItemsFromCart(int cartId) async {
    try {
      var res = await http.post(Uri.parse(API.deleteSelectedCartItems), body: {
        "cart_id": cartId.toString(),
      });
      if (res.statusCode == 200) {
        var resBodyFromDeleteCart = jsonDecode(res.body);

        if (resBodyFromDeleteCart["success"] == true) {
          CurrentUserCartList().getCurrentUserCartList();
        }
      }
    } catch (e) {
      print(e.toString());
    }
    // CartTotalAmount().calculateTotalAmount();
    CartTotalAmount().calculateTotalAmount();
  }
}

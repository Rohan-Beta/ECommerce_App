// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/backend/user_cart_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UpdateCartItem {
  updateItemQuantityInCart(int cartId, int newQuantity) async {
    try {
      var res = await http.post(Uri.parse(API.updateCartItems), body: {
        "cart_id": cartId.toString(),
        "item_quantity": newQuantity.toString(),
      });
      if (res.statusCode == 200) {
        var resBodyOfNewQuantity = jsonDecode(res.body);

        if (resBodyOfNewQuantity["success"] == true) {
          CurrentUserCartList().getCurrentUserCartList();
        } else {
          Fluttertoast.showToast(msg: "Error~");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

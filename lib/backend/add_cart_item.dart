// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/backend/item_details_controller.dart';
import 'package:ecommerce/modell/cloth_model.dart';
import 'package:ecommerce/users/userSharedPreferences/current_user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddCartItem {
  final itemDetailsController = Get.put(ItemDetailsController());
  final CurrentUser currentUser = Get.put(CurrentUser());

  addItemToCart(ClothesModel itemInfo) async {
    try {
      var res = await http.post(
        Uri.parse(API.addToCart),
        body: {
          "user_id": currentUser.user.user_id.toString(),
          "item_id": itemInfo.item_id.toString(),
          "item_quantity": itemDetailsController.quantity.toString(),
          "item_color": itemInfo.item_colors![itemDetailsController.color],
          "item_size": itemInfo.item_sizes![itemDetailsController.size],
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfAddCart = jsonDecode(res.body);

        if (resBodyOfAddCart['success'] == true) {
          Fluttertoast.showToast(msg: "Item added to cart ^-^");
        } else {
          Fluttertoast.showToast(msg: "Error occured , try again `-`");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

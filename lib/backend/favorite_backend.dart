// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/backend/item_details_controller.dart';
import 'package:ecommerce/modell/cloth_model.dart';
import 'package:ecommerce/users/userSharedPreferences/current_user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FavoriteBackend {
  final itemDetailsController = Get.put(ItemDetailsController());
  final CurrentUser currentUser = Get.put(CurrentUser());

  validateFavoriteList(ClothesModel itemInfo) async {
    try {
      var res = await http.post(
        Uri.parse(API.validateFavorite),
        body: {
          "user_id": currentUser.user.user_id.toString(),
          "item_id": itemInfo.item_id.toString(),
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfValidateFavorite = jsonDecode(res.body);

        if (resBodyOfValidateFavorite['favoriteFound'] == true) {
          // Fluttertoast.showToast(msg: "Item is in favorite list ^-^");

          itemDetailsController.setIsFavourite(true);
        } else {
          // Fluttertoast.showToast(msg: "Item is not in favorite list `-`");

          itemDetailsController.setIsFavourite(false);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  addItemToFavorite(ClothesModel itemInfo) async {
    try {
      var res = await http.post(
        Uri.parse(API.addToFavorite),
        body: {
          "user_id": currentUser.user.user_id.toString(),
          "item_id": itemInfo.item_id.toString(),
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfaddFavorite = jsonDecode(res.body);

        if (resBodyOfaddFavorite['success'] == true) {
          Fluttertoast.showToast(msg: "Item added to favorite ^-^");

          validateFavoriteList(itemInfo);
        } else {
          Fluttertoast.showToast(msg: "Error occured , try again `-`");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  deleteItemFromFavorite(ClothesModel itemInfo) async {
    try {
      var res = await http.post(
        Uri.parse(API.deleteFromFavorite),
        body: {
          "user_id": currentUser.user.user_id.toString(),
          "item_id": itemInfo.item_id.toString(),
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfdeleteFavorite = jsonDecode(res.body);

        if (resBodyOfdeleteFavorite['success'] == true) {
          Fluttertoast.showToast(msg: "Item deleted from favorite ^-^");

          validateFavoriteList(itemInfo);
        } else {
          Fluttertoast.showToast(msg: "Error occured , Item not deleted `-`");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

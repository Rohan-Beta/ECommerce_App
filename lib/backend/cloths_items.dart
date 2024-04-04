// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/modell/cloth_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ClothItems {
  Future<List<ClothesModel>> getTerndingClothes() async {
    List<ClothesModel> trendingClothItems = [];

    try {
      var res = await http.post(
        Uri.parse(API.trendingClothes),
      );
      if (res.statusCode == 200) {
        var resBodyOfTrendingItems = jsonDecode(res.body);

        if (resBodyOfTrendingItems["success"] == true) {
          (resBodyOfTrendingItems["clothItemsData"] as List)
              .forEach((eachRecord) {
            trendingClothItems.add(ClothesModel.fromJson(eachRecord));
          });
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    return trendingClothItems;
  }

  Future<List<ClothesModel>> getAllClothes() async {
    List<ClothesModel> allClothItems = [];

    try {
      var res = await http.post(
        Uri.parse(API.allClothes),
      );
      if (res.statusCode == 200) {
        var resBodyOfAllItems = jsonDecode(res.body);

        if (resBodyOfAllItems["success"] == true) {
          (resBodyOfAllItems["clothItemsData"] as List).forEach((eachRecord) {
            allClothItems.add(ClothesModel.fromJson(eachRecord));
          });
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    return allClothItems;
  }
}

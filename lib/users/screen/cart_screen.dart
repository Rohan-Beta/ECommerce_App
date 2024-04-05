import 'package:ecommerce/backend/cart_controller.dart';
import 'package:ecommerce/modell/cart_model.dart';
import 'package:ecommerce/users/userSharedPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CurrentUser currentUser = Get.put(CurrentUser());
  final CartController cartController = Get.put(CartController());

  getCurrentUserCartList() async {
    List<CartModel> cartListOfCurrentUser = [];

    try {} catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}

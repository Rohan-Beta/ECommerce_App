// ignore_for_file: prefer_is_empty, avoid_function_literals_in_foreach_calls

import 'package:ecommerce/backend/cart_controller.dart';
import 'package:ecommerce/users/userSharedPreferences/current_user.dart';
import 'package:get/get.dart';

class CartTotalAmount {
  final CurrentUser currentUser = Get.put(CurrentUser());
  final cartController = Get.put(CartController());

  calculateTotalAmount() {
    cartController.setTotal(0);

    if (cartController.selectedItems.length > 0) {
      cartController.cartList.forEach(
        (itemInCart) {
          if (cartController.selectedItems.contains(itemInCart.cart_id)) {
            double totalAmount = (itemInCart.item_price!) *
                (double.parse(itemInCart.item_quantity.toString()));

            cartController.setTotal(cartController.total + totalAmount);
          }
        },
      );
    }
  }
}

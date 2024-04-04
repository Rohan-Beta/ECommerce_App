// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/backend/item_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ItemCount {
  Widget itemCounter(ItemDetailsController itemDetailsController) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              itemDetailsController
                  .setQuantityItem(itemDetailsController.quantity + 1);
            },
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
          ),
          Text(
            itemDetailsController.quantity.toString(),
            style: TextStyle(
              fontSize: 20,
              color: Colors.purpleAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {
              if (itemDetailsController.quantity - 1 >= 1) {
                itemDetailsController
                    .setQuantityItem(itemDetailsController.quantity - 1);
              }
            },
            icon: Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

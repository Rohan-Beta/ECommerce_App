// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/backend/item_details_controller.dart';
import 'package:ecommerce/modell/cloth_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ItemColorSelection {
  Widget itemColorSelect(
      ClothesModel itemInfo, ItemDetailsController itemDetailsController) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Wrap(
        runSpacing: 8,
        spacing: 8,
        children: List.generate(
          itemInfo.item_colors!.length,
          (index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  itemDetailsController.setColorItem(index);
                },
                child: Container(
                  height: 35,
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: itemDetailsController.color == index
                          ? Colors.transparent
                          : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: itemDetailsController.color == index
                        ? Colors.purpleAccent.withOpacity(0.4)
                        : Colors.black,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    itemInfo.item_colors![index]
                        .replaceAll("[", "")
                        .replaceAll("]", ""),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

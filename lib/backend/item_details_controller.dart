// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';

class ItemDetailsController extends GetxController {
  RxInt _quantityItem = 1.obs;
  RxInt _sizeItem = 0.obs;
  RxInt _colorItem = 0.obs;
  RxBool _isFavourite = false.obs;

  int get quantity => _quantityItem.value;
  int get size => _sizeItem.value;
  int get color => _colorItem.value;
  bool get isFavourite => _isFavourite.value;

  setQuantityItem(int quantityOfItem) {
    _quantityItem.value = quantityOfItem;
  }

  setSizeItem(int sizeOfItem) {
    _sizeItem.value = sizeOfItem;
  }

  setColorItem(int colorOfItem) {
    _colorItem.value = colorOfItem;
  }

  setIsFavourite(bool isFavourite) {
    _isFavourite.value = isFavourite;
  }
}

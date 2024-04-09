// ignore_for_file: prefer_final_fields, invalid_use_of_protected_member

import 'package:ecommerce/modell/cart_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<CartModel> _cartList = <CartModel>[].obs;
  RxList<int> _selectedItems = <int>[].obs;
  RxBool _isSelectedAll = false.obs;
  RxDouble _total = 0.0.obs;

  List<CartModel> get cartList => _cartList.value;
  List<int> get selectedItems => _selectedItems.value;
  bool get isSelectedAll => _isSelectedAll.value;
  double get total => _total.value;

  setList(List<CartModel> list) {
    _cartList.value = list;
  }

  addSelected(int selectedItemCartID) {
    _selectedItems.value.add(selectedItemCartID);
    update();
  }

  deleteSelected(int SelectedItemCartID) {
    _selectedItems.value.remove(SelectedItemCartID);
    update();
  }

  setIsSelectedAll() {
    _isSelectedAll.value = !_isSelectedAll.value;
  }

  clearAllSelectedItems() {
    _selectedItems.value.clear();
    update();
  }

  setTotal(double overallTotal) {
    _total.value = overallTotal;
  }
}

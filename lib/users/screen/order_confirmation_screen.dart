// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, must_be_immutable, prefer_is_empty, depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/modell/order_model.dart';
import 'package:ecommerce/users/userSharedPreferences/current_user.dart';
import 'package:ecommerce/utilss/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class OrderConfirmationScreen extends StatelessWidget {
  final List<int>? selectedCartId;
  final List<Map<String, dynamic>>? selectedCartListItemsInfo;
  final double? totalAmount;
  final String? deliverySystem;
  final String? paymentSystem;
  final String? phoneNumber;
  final String? shipmentAddress;
  final String? note;

  OrderConfirmationScreen({
    super.key,
    required this.selectedCartId,
    required this.selectedCartListItemsInfo,
    required this.totalAmount,
    required this.deliverySystem,
    required this.paymentSystem,
    required this.phoneNumber,
    required this.shipmentAddress,
    required this.note,
  });
  final ImagePicker _picker = ImagePicker();
  CurrentUser currentUser = Get.put(CurrentUser());

  RxList<int> _imageSelectedByte = <int>[].obs;
  Uint8List get imageSelectedByte => Uint8List.fromList(_imageSelectedByte);

  RxString _imageSelectedName = "".obs;
  String get imageSelectedName => _imageSelectedName.value;

  setSelectedImageByte(Uint8List selectedImageByte) {
    _imageSelectedByte.value = selectedImageByte;
  }

  setSelectedImageName(String selectedImageName) {
    _imageSelectedName.value = selectedImageName;
  }

  chooseImageFromGallery() async {
    final pickedImageXFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImageXFile != null) {
      final bytesOfImage = await pickedImageXFile.readAsBytes();

      setSelectedImageByte(bytesOfImage);
      setSelectedImageName(path.basename(pickedImageXFile.path));
    }
  }

  saveNewOrderInfo() async {
    String selectedItemString = selectedCartListItemsInfo!
        .map((eachSelectedItem) => jsonEncode(eachSelectedItem))
        .toList()
        .join("||");

    OrderModel orderModel = OrderModel(
      order_id: 1,
      user_id: currentUser.user.user_id,
      selected_items: selectedItemString,
      delivery_system: deliverySystem,
      payment_system: paymentSystem,
      note: note,
      total_amount: totalAmount,
      image: imageSelectedName,
      status: "",
      date_time: DateTime.now(),
      shipment_address: shipmentAddress,
      phone_number: phoneNumber,
    );

    try {
      var res = await http.post(
        Uri.parse(API.addToOrder),
        body: orderModel.toJson(
          base64Encode(imageSelectedByte),
        ),
      );
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // image
                Image.asset(
                  "MyAssets/imagess/transaction.png",
                  width: 160,
                ),
                SizedBox(
                  height: 6,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Please Attach Transaction \nProof ScreenShot",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                // select image button

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent),
                  child: Text(
                    "Select Image",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    chooseImageFromGallery();
                  },
                ),
                SizedBox(height: 20),

                // display selected image by user
                Obx(
                  () => ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: screenSize.width * 0.7,
                      maxHeight: screenSize.height * 0.6,
                    ),
                    child: imageSelectedByte.length > 0
                        ? Image.memory(
                            imageSelectedByte,
                            fit: BoxFit.contain,
                          )
                        : Placeholder(
                            color: Colors.white60,
                          ),
                  ),
                ),
                SizedBox(height: 30),

                // confirm and proceed

                Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: imageSelectedByte.length > 0
                          ? Colors.purpleAccent
                          : Colors.grey,
                    ),
                    child: Text(
                      "Confirm & Proceed",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      if (imageSelectedByte.length > 0) {
                        // save order info
                        saveNewOrderInfo();
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Please attach transaction proof or screenshot");
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

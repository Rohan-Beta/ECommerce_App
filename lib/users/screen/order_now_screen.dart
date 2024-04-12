// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:ecommerce/backend/order_now_controller.dart';
import 'package:ecommerce/users/screen/order_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class OrderNowScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedCartListItemsInfo;
  final double totalAmount;
  final List<int> selectedCartId;

  OrderNowScreen({
    super.key,
    required this.selectedCartListItemsInfo,
    required this.totalAmount,
    required this.selectedCartId,
  });
  TextEditingController phoneController = TextEditingController();
  TextEditingController shipmentController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  OrderNowController orderNowController = Get.put(OrderNowController());
  List<String> deliverySystemNamesList = [
    "FedEx",
    "DHL (recommended)",
    "United Parcel Service"
  ];
  List<String> paymentSystemNamesList = [
    "Apple Pay",
    "Google Pay",
    "Phone Pay",
    "Cash On Delivery"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Order Now"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 20),

            // show selected item from cart

            displaySelectedCartItem(),

            // delivery system

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Delivery System: ",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: deliverySystemNamesList.map((deliverySystemName) {
                  return Obx(
                    () => RadioListTile<String>(
                      tileColor: Colors.white24,
                      dense: true,
                      activeColor: Colors.purpleAccent,
                      title: Text(
                        deliverySystemName,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white38,
                        ),
                      ),
                      value: deliverySystemName,
                      groupValue: orderNowController.deliverySystem,
                      onChanged: (newDeliverySystemValue) {
                        orderNowController
                            .setDeliverySystem(newDeliverySystemValue!);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 30),

            // payment system

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment System: ",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Company Account Number/ID: \nrohitraha952@oksbi",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: paymentSystemNamesList.map(
                  (paymentSystemName) {
                    return Obx(
                      () => RadioListTile<String>(
                        tileColor: Colors.white24,
                        dense: true,
                        activeColor: Colors.purpleAccent,
                        title: Text(
                          paymentSystemName,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white38,
                          ),
                        ),
                        value: paymentSystemName,
                        groupValue: orderNowController.paymentSystem,
                        onChanged: (newpaymentSystemValue) {
                          orderNowController
                              .setPaymentSystem(newpaymentSystemValue!);
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            SizedBox(height: 20),
            // user phone number

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Phone Number: ",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: TextField(
                style: TextStyle(color: Colors.white54),
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: "Enter your phone number",
                  hintStyle: TextStyle(
                    color: Colors.white24,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.white24,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            // shipment address

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Shipment Address: ",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: TextField(
                style: TextStyle(color: Colors.white54),
                controller: shipmentController,
                decoration: InputDecoration(
                  hintText: "Enter your shipment address",
                  hintStyle: TextStyle(
                    color: Colors.white24,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.white24,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            // note to seller

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Note To Seller: (optional)",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: TextField(
                style: TextStyle(color: Colors.white54),
                controller: noteController,
                decoration: InputDecoration(
                  hintText: "Enter your note to seller",
                  hintStyle: TextStyle(
                    color: Colors.white24,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.white24,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100, bottom: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent),
                child: Row(
                  children: [
                    Text(
                      "₹" + totalAmount.toStringAsFixed(2),
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                    Text(
                      "Pay Now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () {
                  if (phoneController.text.isNotEmpty &&
                      shipmentController.text.isNotEmpty) {
                    Get.to(
                      OrderConfirmationScreen(
                        selectedCartId: selectedCartId,
                        selectedCartListItemsInfo: selectedCartListItemsInfo,
                        totalAmount: totalAmount,
                        deliverySystem: orderNowController.deliverySystem,
                        paymentSystem: orderNowController.paymentSystem,
                        phoneNumber: phoneController.text,
                        shipmentAddress: shipmentController.text,
                        note: noteController.text,
                      ),
                    );
                  } else {
                    Fluttertoast.showToast(msg: "Please fill the form");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  displaySelectedCartItem() {
    return Column(
      children: List.generate(
        selectedCartListItemsInfo.length,
        (index) {
          Map<String, dynamic> eachSelectedItem =
              selectedCartListItemsInfo[index];

          return Container(
            margin: EdgeInsets.fromLTRB(
              16,
              index == 0 ? 16 : 8,
              16,
              index == selectedCartListItemsInfo.length - 1 ? 16 : 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white10,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 6,
                  color: Colors.black26,
                ),
              ],
            ),
            child: Row(
              children: [
                // image
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  child: FadeInImage(
                    height: 150,
                    width: 130,
                    fit: BoxFit.cover,
                    placeholder:
                        AssetImage("MyAssets/imagess/place_holder.png"),
                    image: NetworkImage(
                      eachSelectedItem["item_image"], // product image
                    ),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                        ),
                      );
                    },
                  ),
                ),
                // name

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          eachSelectedItem["item_name"],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        // size

                        Text(
                          eachSelectedItem["item_size"]
                              .toString()
                              .replaceAll("[", "")
                              .replaceAll("]", ""), // item size and color
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                        // item color
                        Text(
                          eachSelectedItem["item_color"]
                              .toString()
                              .replaceAll("[", "")
                              .replaceAll("]", ""), // item size and color
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                        ),

                        SizedBox(height: 20),
                        // item price

                        Text(
                          "₹" + eachSelectedItem["total_amount"].toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purpleAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // item quantity

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Q: " + eachSelectedItem["item_quantity"].toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

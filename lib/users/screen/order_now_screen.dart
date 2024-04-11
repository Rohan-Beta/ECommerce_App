// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/backend/order_now_controller.dart';
import 'package:flutter/material.dart';
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
        title: Text("Delivery Process"),
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
              child: Text(
                "Payment System: ",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold),
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
          ],
        ),
      ),
    );
  }
}

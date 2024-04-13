// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls, avoid_print, prefer_is_empty

import 'dart:convert';

import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/modell/order_model.dart';
import 'package:ecommerce/users/screen/order_user_detail_scree.dart';
import 'package:ecommerce/users/userSharedPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class OrderUserScreen extends StatelessWidget {
  OrderUserScreen({super.key});

  final currentUser = Get.put(CurrentUser());

  Future<List<OrderModel>> getCurrentUserOrderList() async {
    List<OrderModel> orderListOfCurrentUser = [];

    try {
      var res = await http.post(
        Uri.parse(API.readOrders),
        body: {
          "currentOnlineUserID": currentUser.user.user_id.toString(),
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfCurrentUserOrderItems = jsonDecode(res.body);

        if (resBodyOfCurrentUserOrderItems['success'] == true) {
          (resBodyOfCurrentUserOrderItems['currentUserOrderData'] as List)
              .forEach(
            (eachCurrentUserOrderItem) {
              orderListOfCurrentUser
                  .add(OrderModel.fromJson(eachCurrentUserOrderItem));
            },
          );
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    return orderListOfCurrentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // my order

                  GestureDetector(
                    onTap: () {
                      // send user to order history screen
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Image.asset(
                            "MyAssets/imagess/orders_icon.png",
                            width: 140,
                          ),
                          Text(
                            "My Orders",
                            style: TextStyle(
                              color: Colors.purpleAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // orders history

                  Column(
                    children: [
                      Image.asset(
                        "MyAssets/imagess/history_icon.png",
                        width: 45,
                      ),
                      Text(
                        "Orders History",
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Here are your successfully placed orders. ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // display users order list

            Expanded(
              child: displayOrderList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayOrderList(context) {
    return FutureBuilder(
      future: getCurrentUserOrderList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == null) {
          return Center(
            child: Text(
              "No Order Found",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        if (snapshot.data!.length > 0) {
          List<OrderModel> orderList = snapshot.data!;

          return ListView.separated(
            itemBuilder: (context, index) {
              OrderModel eachOrderData = orderList[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white24,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: ListTile(
                      onTap: () {
                        Get.to(
                          OrderUserDetailScreen(
                            clickedOrderInfo: eachOrderData,
                          ),
                        );
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order ID: ${eachOrderData.order_id}",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Amount ₹: ${eachOrderData.total_amount}",
                            style: TextStyle(
                              color: Colors.purpleAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // date and time

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                DateFormat("dd MMMM , yyyy")
                                    .format(eachOrderData.date_time!),
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                DateFormat("hh:mm a")
                                    .format(eachOrderData.date_time!),
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),

                          Icon(
                            Icons.navigate_next,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  height: 1,
                  thickness: 1,
                ),
              );
            },
            itemCount: orderList.length,
          );
        } else {
          return Center(
            child: Text(
              "Noting Found",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      },
    );
  }
}

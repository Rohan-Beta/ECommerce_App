// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/modell/order_model.dart';
import 'package:ecommerce/utilss/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderUserDetailScreen extends StatefulWidget {
  final OrderModel clickedOrderInfo;
  const OrderUserDetailScreen({
    super.key,
    required this.clickedOrderInfo,
  });

  @override
  State<OrderUserDetailScreen> createState() => _OrderUserDetailScreenState();
}

class _OrderUserDetailScreenState extends State<OrderUserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          DateFormat("dd MMMM , yyyy - hh:mm a")
              .format(widget.clickedOrderInfo.date_time!),
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // display items belong to clicked order
                displayClickedOrderItem(),

                SizedBox(height: 20),

                showTitle("Phone Number: "),
                SizedBox(height: 8),
                showContentText(widget.clickedOrderInfo.phone_number!),

                SizedBox(height: 30),

                showTitle("Shipment Address: "),
                SizedBox(height: 8),
                showContentText(widget.clickedOrderInfo.shipment_address!),

                SizedBox(height: 30),

                showTitle("Delivery System: "),
                SizedBox(height: 8),
                showContentText(widget.clickedOrderInfo.delivery_system!),

                SizedBox(height: 30),

                showTitle("Payment System: "),
                SizedBox(height: 8),
                showContentText(
                    widget.clickedOrderInfo.payment_system.toString()),

                SizedBox(height: 30),

                showTitle("Note To Seller: "),
                SizedBox(height: 8),
                showContentText(widget.clickedOrderInfo.note!),

                SizedBox(height: 30),

                showTitle("Total Amount: "),
                SizedBox(height: 8),
                showContentText(
                    widget.clickedOrderInfo.total_amount.toString()),

                SizedBox(height: 30),

                showTitle("Payment Proof: "),
                SizedBox(height: 8),
                FadeInImage(
                  width: screenSize.width * 0.8,
                  fit: BoxFit.fitWidth,
                  placeholder: AssetImage("MyAssets/imagess/place_holder.png"),
                  image: NetworkImage(
                    API.hostTransactionImages + widget.clickedOrderInfo.image!,
                  ),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showTitle(String titleText) {
    return Text(
      titleText,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.grey,
      ),
    );
  }

  Widget showContentText(String contentText) {
    return Text(
      contentText,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.white,
      ),
    );
  }

  Widget displayClickedOrderItem() {
    List<String> clickedOrderItemInfo =
        widget.clickedOrderInfo.selected_items!.split("||");
    return Column(
      children: List.generate(
        clickedOrderItemInfo.length,
        (index) {
          Map<String, dynamic> itemInfo =
              jsonDecode(clickedOrderItemInfo[index]);

          return Container(
            margin: EdgeInsets.fromLTRB(
              16,
              index == 0 ? 16 : 8,
              16,
              index == clickedOrderItemInfo.length - 1 ? 16 : 8,
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
                      itemInfo["item_image"], // product image
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
                          itemInfo["item_name"],
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
                          itemInfo["item_size"]
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
                          itemInfo["item_color"]
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
                          "₹${itemInfo["total_amount"]}",
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
                    "Q: ${itemInfo["item_quantity"]}",
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

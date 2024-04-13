// ignore_for_file: non_constant_identifier_names

class OrderModel {
  int? order_id;
  int? user_id;
  String? selected_items;
  String? delivery_system;
  String? payment_system;
  String? note;
  double? total_amount;
  String? image;
  String? status;
  DateTime? date_time;
  String? shipment_address;
  String? phone_number;

  OrderModel({
    required this.order_id,
    required this.user_id,
    required this.selected_items,
    required this.delivery_system,
    required this.payment_system,
    required this.note,
    required this.total_amount,
    required this.image,
    required this.status,
    required this.date_time,
    required this.shipment_address,
    required this.phone_number,
  });
  Map<String, dynamic> toJson(String imageSelectedBase64) => {
        "order_id": order_id.toString(),
        "user_id": user_id.toString(),
        "selected_items": selected_items,
        "delivery_system": delivery_system,
        "payment_system": payment_system,
        "note": note,
        "total_amount": total_amount!.toStringAsFixed(2),
        "image": image,
        "status": status,
        "shipment_address": shipment_address,
        "phone_number": phone_number,
        "image_file": imageSelectedBase64
      };
}

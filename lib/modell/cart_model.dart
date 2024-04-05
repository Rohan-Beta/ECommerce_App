// ignore_for_file: non_constant_identifier_names

class CartModel {
  int? cart_id;
  int? user_id;
  int? item_id;
  int? item_quantity;
  String? item_color;
  String? item_size;
  String? item_name;
  double? item_rating;
  List<String>? item_tags;
  double? item_price;
  List<String>? item_sizes;
  List<String>? item_colors;
  String? item_description;
  String? item_image;

  CartModel({
    required this.cart_id,
    required this.user_id,
    required this.item_id,
    required this.item_quantity,
    required this.item_color,
    required this.item_size,
    required this.item_name,
    required this.item_rating,
    required this.item_tags,
    required this.item_price,
    required this.item_sizes,
    required this.item_colors,
    required this.item_description,
    required this.item_image,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        cart_id: int.parse(json["cart_id"]),
        user_id: int.parse(json["user_id"]),
        item_id: int.parse(json["item_id"]),
        item_quantity: int.parse(json["item_quantity"]),
        item_color: json["item_color"],
        item_size: json["item_size"],
        item_name: json["item_name"],
        item_rating: double.parse(json["item_rating"]),
        item_tags: json["item_tags"].toString().split(", "),
        item_price: double.parse(json["item_price"]),
        item_sizes: json["item_sizes"].toString().split(", "),
        item_colors: json["item_colors"].toString().split(", "),
        item_description: json["item_description"],
        item_image: json["item_image"],
      );
}

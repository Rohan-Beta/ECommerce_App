// ignore_for_file: non_constant_identifier_names

class FavoriteModel {
  int? favorite_id;
  int? user_id;
  int? item_id;
  String? item_name;
  double? item_rating;
  List<String>? item_tags;
  double? item_price;
  List<String>? item_sizes;
  List<String>? item_colors;
  String? item_description;
  String? item_image;

  FavoriteModel({
    required this.favorite_id,
    required this.user_id,
    required this.item_id,
    required this.item_name,
    required this.item_rating,
    required this.item_tags,
    required this.item_price,
    required this.item_sizes,
    required this.item_colors,
    required this.item_description,
    required this.item_image,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        favorite_id: int.parse(json["favorite_id"]),
        user_id: int.parse(json["user_id"]),
        item_id: int.parse(json["item_id"]),
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

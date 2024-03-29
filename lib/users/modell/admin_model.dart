// ignore_for_file: non_constant_identifier_names

class AdminModel {
  int admin_id;
  String admin_name;
  String admin_email;
  String admin_password;

  AdminModel({
    required this.admin_id,
    required this.admin_name,
    required this.admin_email,
    required this.admin_password,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        admin_id: int.parse(json["admin_id"]),
        admin_name: json["admin_name"],
        admin_email: json["admin_email"],
        admin_password: json["admin_password"],
      );

  Map<String, dynamic> toJson() => {
        "admin_id": admin_id.toString(),
        "admin_name": admin_name,
        "admin_email": admin_email,
        "admin_password": admin_password,
      };
}

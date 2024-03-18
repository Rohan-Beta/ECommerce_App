// ignore_for_file: non_constant_identifier_names

class UserModel {
  int user_id;
  String user_name;
  String user_email;
  String user_password;

  UserModel({
    required this.user_id,
    required this.user_name,
    required this.user_email,
    required this.user_password,
  });

  Map<String, dynamic> toJson() => {
        "user_id": user_id.toString(),
        "user_name": user_name,
        "user_email": user_email,
        "user_password": user_password,
      };
}

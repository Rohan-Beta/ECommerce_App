import 'dart:convert';

import 'package:ecommerce/users/modell/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
  // save user information

  static Future<void> saveAndRememberUser(UserModel userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }
}

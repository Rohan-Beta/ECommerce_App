import 'dart:convert';

import 'package:ecommerce/modell/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
  // save user info in local storage

  static Future<void> storeUserInfo(UserModel userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }

  // read user info

  static Future<UserModel?> readUserInfo() async {
    UserModel? currentUserInfo;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");

    if (userInfo != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUserInfo = UserModel.fromJson(userDataMap);
    }
    return currentUserInfo;
  }

  // remove user info

  static Future<void> removeUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");
  }
}

// ignore_for_file: prefer_final_fields

import 'package:ecommerce/modell/user_model.dart';
import 'package:ecommerce/users/userSharedPreferences/user_shared_preferences.dart';
import 'package:get/get.dart';

// after successfully sign in store user info in local storage

class CurrentUser extends GetxController {
  Rx<UserModel> _currentUser =
      UserModel(user_id: 0, user_name: '', user_email: '', user_password: '')
          .obs;

  UserModel get user => _currentUser.value;

  getUserInfo() async {
    UserModel? getUserInfoFromLocalStorage =
        await RememberUserPrefs.readUserInfo();

    _currentUser.value = getUserInfoFromLocalStorage!;
  }
}

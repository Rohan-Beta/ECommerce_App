// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields

import 'package:ecommerce/users/screen/favorites_screen.dart';
import 'package:ecommerce/users/screen/home_screen.dart';
import 'package:ecommerce/users/screen/order_user_screen.dart';
import 'package:ecommerce/users/screen/profile_user_screen.dart';
import 'package:ecommerce/users/userSharedPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  final List<Widget> _fragmentScreens = [
    HomeScreen(),
    FavoritesScreen(),
    OrderUserScreen(),
    ProfilUserScreen(),
  ];

  List _navigationButtons = [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_icon": Icons.favorite,
      "non_active_icon": Icons.favorite_border,
      "label": "Favorites",
    },
    {
      "active_icon": FontAwesomeIcons.boxOpen,
      "non_active_icon": FontAwesomeIcons.box,
      "label": "Orders",
    },
    {
      "active_icon": Icons.person,
      "non_active_icon": Icons.person_outline,
      "label": "Profile",
    },
  ];

  final RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Obx(
              () => _fragmentScreens[_indexNumber.value],
            ),
          ),
          backgroundColor: Colors.black,
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              currentIndex: _indexNumber.value,
              onTap: (value) {
                _indexNumber.value = value;
              },
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white24,
              items: List.generate(
                4,
                (index) {
                  var navBottonProperty = _navigationButtons[index];
                  return BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    icon: Icon(navBottonProperty["non_active_icon"]),
                    activeIcon: Icon(navBottonProperty["active_icon"]),
                    label: navBottonProperty["label"],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

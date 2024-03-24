// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields

import 'package:ecommerce/users/fragments_screen/favorites_fragments_screen.dart';
import 'package:ecommerce/users/fragments_screen/home_fragment_screen.dart';
import 'package:ecommerce/users/fragments_screen/order_fragment_screen.dart';
import 'package:ecommerce/users/fragments_screen/profile_fragment_screen.dart';
import 'package:ecommerce/users/userSharedPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DashboardOfFragmentsScreen extends StatelessWidget {
  DashboardOfFragmentsScreen({super.key});

  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  List<Widget> _fragmentScreens = [
    HomeFragementScreen(),
    FavoritesScreen(),
    OrderFragmentScreen(),
    ProfileFragmentScreen(),
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller) {
        return Scaffold();
      },
    );
  }
}

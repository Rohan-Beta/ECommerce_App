// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:ecommerce/admins/login_admin.dart';
import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/users/authentication/sign_in_screen.dart';
import 'package:ecommerce/users/screen/dashboard_screen.dart';
import 'package:ecommerce/modell/user_model.dart';
import 'package:ecommerce/users/userSharedPreferences/user_shared_preferences.dart';
import 'package:ecommerce/utilss/next_screen.dart';
import 'package:ecommerce/utilss/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rive/rive.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  Size screenSize = MyScreenSize().getScreenSize();
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isObsecure = true.obs;

  var animationLink = "MyAssets/imagess/login.riv";
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  late StateMachineController? stateMachineController;

  loginUser() async {
    try {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "user_email": emailController.text.trim(),
          "user_password": passwordController.text.trim(),
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfLogIn = jsonDecode(res.body);

        if (resBodyOfLogIn['success'] == true) {
          Fluttertoast.showToast(msg: "LogIn Successfully ^-^");

          UserModel userInfo = UserModel.fromJson(resBodyOfLogIn["userData"]);

          // save user data to local storage

          await RememberUserPrefs.storeUserInfo(userInfo);

          Future.delayed(Duration(seconds: 2), () {
            isChecking!.change(false);
            isHandsUp!.change(false);
            trigFail!.change(false);
            trigSuccess!.change(true);

            nextScreenReplace(context, DashboardScreen());

            // Get.to(DashboardOfFragmentsScreen());
          });
        } else {
          isChecking!.change(false);
          isHandsUp!.change(false);
          trigSuccess!.change(false);
          trigFail!.change(true);

          Fluttertoast.showToast(
              msg: "Please enter valid email or password , try again `-`");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void lookOnTheTextField() {
    isHandsUp?.change(false);
    isChecking?.change(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constains) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constains.maxHeight,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: screenSize.width,
                      height: 350,
                      child: RiveAnimation.asset(
                        animationLink,
                        fit: BoxFit.fill,
                        stateMachines: ['Login Machine'],
                        onInit: (artBoard) {
                          stateMachineController =
                              StateMachineController.fromArtboard(
                                  artBoard, 'Login Machine');
                          if (stateMachineController == null) {
                            return;
                          }
                          artBoard.addController(stateMachineController!);
                          isChecking =
                              stateMachineController?.findInput('isChecking');
                          isHandsUp =
                              stateMachineController?.findInput('isHandsUp');
                          trigSuccess =
                              stateMachineController?.findInput('trigSuccess');
                          trigFail =
                              stateMachineController?.findInput('trigFail');
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(60),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, -3),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 30, right: 30, bottom: 8),
                          child: Column(
                            children: [
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),

                                    // email

                                    TextFormField(
                                      onTap: lookOnTheTextField,
                                      // onChanged: moveEyeBalls,
                                      controller: emailController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Email can not be empty";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Icon(
                                            Icons.email,
                                            color: Colors.black,
                                          ),
                                        ),
                                        hintText: "Yours@gmail.com",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.blue),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Colors.red),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 6,
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    // password

                                    Obx(
                                      () => TextFormField(
                                        onChanged: (value) {
                                          if (isChecking != null) {
                                            isChecking!.change(false);
                                          }
                                          if (isHandsUp == null) {
                                            return;
                                          }
                                          isHandsUp!.change(true);
                                        },
                                        controller: passwordController,
                                        obscureText: isObsecure.value,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "password can not be empty";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          icon: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Icon(
                                              Icons.key,
                                              color: Colors.black,
                                            ),
                                          ),
                                          hintText: "Password",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                              color: Colors.white60,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                                color: Colors.blue),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 6,
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          suffixIcon: Obx(
                                            () => GestureDetector(
                                              onTap: () {
                                                isObsecure.value =
                                                    !isObsecure.value;
                                              },
                                              child: Icon(
                                                isObsecure.value
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),

                                    // log in button

                                    SizedBox(
                                      height: 35,
                                      width: 100,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white24),
                                        child: const Text(
                                          "LogIn",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            isChecking!.change(false);
                                            isHandsUp!.change(false);
                                            trigFail!.change(false);
                                            trigSuccess!.change(true);
                                            loginUser();
                                          } else {
                                            isChecking!.change(false);
                                            isHandsUp!.change(false);
                                            trigSuccess!.change(false);
                                            trigFail!.change(true);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // sign in user

                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account?",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        nextScreen(context, SignInScreen());
                                      },
                                      child: Text(
                                        "SignUp Here",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "OR",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              // admin login

                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Are you an Admin?",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        nextScreen(context, LogInAdminScreen());
                                      },
                                      child: Text(
                                        "Click Here",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

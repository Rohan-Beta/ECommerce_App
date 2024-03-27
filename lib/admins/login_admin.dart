// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:ecommerce/admins/admin_upload_items.dart';
import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/utilss/next_screen.dart';
import 'package:ecommerce/utilss/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rive/rive.dart';

class LogInAdminScreen extends StatefulWidget {
  const LogInAdminScreen({super.key});

  @override
  State<LogInAdminScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInAdminScreen> {
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

  loginAdmin() async {
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

          Future.delayed(Duration(seconds: 2), () {
            isChecking!.change(false);
            isHandsUp!.change(false);
            trigFail!.change(false);
            trigSuccess!.change(true);

            nextScreenReplace(context, AdminUploadItemsScreen());

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
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
        title: Text("Admin Login"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
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
                                            loginAdmin();
                                          } else {
                                            isChecking!.change(false);
                                            isHandsUp!.change(false);
                                            trigSuccess!.change(false);
                                            trigFail!.change(true);
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
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

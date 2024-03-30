// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:ecommerce/admins/authentication_admin/login_admin.dart';
import 'package:ecommerce/admins/screen_admin/admin_upload_items.dart';
import 'package:ecommerce/utilss/next_screen.dart';
import 'package:ecommerce/utilss/screen_size.dart';
import 'package:ecommerce/utilss/text_form_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UploadItemDescAdmin extends StatefulWidget {
  final XFile? pickedImageXFile;

  const UploadItemDescAdmin({super.key, required this.pickedImageXFile});

  @override
  State<UploadItemDescAdmin> createState() => _UploadItemDescAdminState();
}

class _UploadItemDescAdminState extends State<UploadItemDescAdmin> {
  var formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sizesController = TextEditingController();
  TextEditingController colorsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var imageLink = "";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MyScreenSize().getScreenSize();

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black87,
                Colors.deepPurple,
              ],
            ),
          ),
        ),
        title: Text(
          "Product Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            nextScreenReplace(context, LogInAdminScreen());
          },
          icon: Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ),
        // change button

        actions: [
          TextButton(
            onPressed: () {
              nextScreenReplace(context, AdminUploadItemsScreen());
            },
            child: Text(
              "Change?",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: screenSize.height * 0.4,
              width: screenSize.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(
                    File(widget.pickedImageXFile!.path),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
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

                        // name

                        MyTextForm().myText(nameController, "Product Name",
                            "Name can not be empty", Icons.sell),

                        SizedBox(
                          height: 18,
                        ),

                        // raing

                        MyTextForm().myText(ratingController, "Product Rating",
                            "Rating can not be empty", Icons.rate_review),

                        SizedBox(
                          height: 18,
                        ),

                        // tags

                        MyTextForm().myText(tagsController, "Product Tags",
                            "Tags can not be empty", Icons.tag),

                        SizedBox(
                          height: 18,
                        ),

                        // price

                        MyTextForm().myText(priceController, "Product Price",
                            "Price can not be empty", Icons.price_change),

                        SizedBox(
                          height: 18,
                        ),

                        // sizes

                        MyTextForm().myText(sizesController, "Product Sizes",
                            "Sizes can not be empty", Icons.picture_in_picture),

                        SizedBox(
                          height: 18,
                        ),

                        // colors

                        MyTextForm().myText(colorsController, "Product Colors",
                            "Colors can not be empty", Icons.color_lens),

                        SizedBox(
                          height: 18,
                        ),

                        // desc

                        MyTextForm().myText(
                            descriptionController,
                            "Product Description",
                            "Description can not be empty",
                            Icons.description),

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
                              "Upload",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                nextScreenReplace(context, LogInAdminScreen());
                                Fluttertoast.showToast(
                                    msg: "Product Uploaded Successfully");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

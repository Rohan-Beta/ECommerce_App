// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_adjacent_string_concatenation, avoid_print, use_build_context_synchronously, must_be_immutable, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/admins/authentication_admin/login_admin.dart';
import 'package:ecommerce/admins/screen_admin/admin_upload_items.dart';
import 'package:ecommerce/api_connection/api_connection.dart';
import 'package:ecommerce/utilss/next_screen.dart';
import 'package:ecommerce/utilss/screen_size.dart';
import 'package:ecommerce/utilss/text_form_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadItemDescAdmin extends StatefulWidget {
  XFile? pickedImageXFile;

  UploadItemDescAdmin({super.key, required this.pickedImageXFile});

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

  // upload image with the help of imgur api

  uploadItemImage() async {
    var requestImgurAPi = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.imgur.com/3/image"),
    );
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    requestImgurAPi.fields['title'] = imageName;
    requestImgurAPi.headers['Authorization'] = "Client-ID " + "75aa8addad51fd6";

    var imageFile = await http.MultipartFile.fromPath(
      'image',
      widget.pickedImageXFile!.path,
      filename: imageName,
    );
    requestImgurAPi.files.add(imageFile);
    var responseFromImgurApi = await requestImgurAPi.send();

    var responseDataFromImgurApi = await responseFromImgurApi.stream.toBytes();

    var resultFromImgurApi = String.fromCharCodes(responseDataFromImgurApi);

    // print("Result ::");
    // print(resultFromImgurApi);

    Map<String, dynamic> jsonRes = json.decode(resultFromImgurApi);

    imageLink = (jsonRes["data"]["link"]).toString();
    String deleteHash = (jsonRes["data"]["deletehash"]).toString();

    saveItemInfoToDB();
  }

  saveItemInfoToDB() async {
    List<String> tagsList = tagsController.text.split(',');
    List<String> sizesList = sizesController.text.split(',');
    List<String> colorsList = colorsController.text.split(',');

    try {
      var res = await http.post(
        Uri.parse(API.uploadNewItem),
        body: {
          'item_id': '1',
          'item_name': nameController.text.trim().toString(),
          'item_rating': ratingController.text.trim().toString(),
          'item_tags': tagsList.toString(),
          'item_price': priceController.text.trim().toString(),
          'item_sizes': sizesList.toString(),
          'item_colors': colorsList.toString(),
          'item_description': descriptionController.text.trim().toString(),
          'item_image': imageLink.toString(),
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfUploadItem = jsonDecode(res.body);

        if (resBodyOfUploadItem['success'] == true) {
          Fluttertoast.showToast(msg: "New item uploaded successfully ^-^");
          // nextScreenReplace(context, LogInAdminScreen());
          setState(() {
            widget.pickedImageXFile = null;
            nameController.clear();
            ratingController.clear();
            tagsController.clear();
            priceController.clear();
            sizesController.clear();
            colorsController.clear();
            descriptionController.clear();
          });
          Get.to(AdminUploadItemsScreen());
        } else {
          Fluttertoast.showToast(msg: "Item not uploaded , Error ~");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

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
            setState(() => widget.pickedImageXFile = null);
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
              setState(() => widget.pickedImageXFile = null);
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
                                Fluttertoast.showToast(msg: "Uploading...");
                                uploadItemImage();
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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:ecommerce/admins/authentication_admin/login_admin.dart';
import 'package:ecommerce/admins/screen_admin/admin_get_all_orders.dart';
import 'package:ecommerce/admins/screen_admin/upload_item_desc_admin.dart';
import 'package:ecommerce/utilss/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminUploadItemsScreen extends StatefulWidget {
  const AdminUploadItemsScreen({super.key});

  @override
  State<AdminUploadItemsScreen> createState() => _AdminUploadItemsState();
}

class _AdminUploadItemsState extends State<AdminUploadItemsScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImageXFile;

  captureImageWithPhoneCamera() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.camera);

    Navigator.pop(context);

    setState(() => pickedImageXFile);
  }

  captureImageFromPhoneGallery() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.gallery);

    Navigator.pop(context);

    setState(() => pickedImageXFile);
  }

  dialogBoxForImagePickingOrCapturing() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Colors.black,
          title: Text(
            "Item Image",
            style: TextStyle(
                color: Colors.deepPurple, fontWeight: FontWeight.bold),
          ),
          children: [
            SimpleDialogOption(
              child: Text(
                "Capture With Phone Camera",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                captureImageWithPhoneCamera();
              },
            ),
            SimpleDialogOption(
              child: Text(
                "Select Image From Phone Gallery",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                captureImageFromPhoneGallery();
              },
            ),
            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return pickedImageXFile == null
        ? Scaffold(
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
              title: GestureDetector(
                onTap: () {
                  Get.to(AdminGetAllOrdersScreen());
                },
                child: Text(
                  "New Orders",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
            ),
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black54,
                      Colors.deepPurple,
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        color: Colors.white54,
                        size: 200,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 35,
                            width: 145,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black38),
                              child: const Text(
                                "Add New Item",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                dialogBoxForImagePickingOrCapturing();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : UploadItemDescAdmin(pickedImageXFile: pickedImageXFile);
  }
}

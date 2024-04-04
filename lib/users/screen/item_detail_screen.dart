import 'package:ecommerce/modell/cloth_model.dart';
import 'package:flutter/material.dart';

class ItemDetailScreen extends StatefulWidget {
  final ClothesModel itemInfo;

  const ItemDetailScreen({super.key, required this.itemInfo});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}

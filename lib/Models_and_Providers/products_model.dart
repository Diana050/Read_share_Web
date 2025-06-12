import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String id, title, author, imageUrl, productCategoryName, description;
  final double price;
  bool isOnFire;

  ProductModel({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.productCategoryName,
    required this.price,
    required this.isOnFire,
    required this.description,
  });
}

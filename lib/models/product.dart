import 'package:flutter/material.dart';

class Product {
  final int productID;
  final String heroName;
  final int price;
  final int categoryID;
  final String image;
  final String packingType;
  final String name;
  final String description;
  final int stock;
  const Product(
      {this.productID,
      @required this.categoryID,
      this.heroName,
      this.price,
      this.image,
      this.packingType,
      this.name,
      this.stock,
      this.description});
}

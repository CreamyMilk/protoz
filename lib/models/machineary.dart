import 'package:flutter/material.dart';

class Machinery {
  final int modelNo;
  final String? heroName;
  final double? price;
  final int categoryID;
  final String? image;
  final String? packingType;
  final String? name;
  final String? description;
  final int? stock;
  final bool isBooked;
  const Machinery(
      {required this.modelNo,
      required this.categoryID,
      this.heroName,
      this.isBooked = false,
      this.price,
      this.image,
      this.packingType,
      this.name,
      this.stock,
      this.description});
}

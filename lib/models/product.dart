class Product {
  final int productID;
  final String? heroName;
  final int price;
  final int? categoryID;
  final String image;
  final String packingType;
  final String name;
  final String description;
  final int stock;
  const Product(
      {required this.productID,
      this.categoryID,
      this.heroName,
      required this.price,
      required this.image,
      required this.packingType,
      required this.name,
      required this.stock,
      required this.description});
}

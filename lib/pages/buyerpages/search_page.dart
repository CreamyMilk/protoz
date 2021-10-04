import 'package:flutter/material.dart';
import 'package:proto/models/product.dart';
import 'package:proto/pages/buyerpages/products_list.dart';

import 'get_categories_future.dart';

class ProductSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: searchProductsList(query),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (projectSnap.data == null) {
            return const Center(child: Text("Sadly you have no products"));
          } else if (projectSnap.data != null) {
            if ((projectSnap.data as List).isEmpty) {
              return const Center(child: Text("Product Not Found"));
            }
            return ListView.builder(
                itemCount: (projectSnap.data as List).length,
                itemBuilder: (context, index) {
                  var item = (projectSnap.data as List)[index];
                  return ProductListItem(
                      p: Product(
                    productID: item["ID"],
                    heroName: item["ID"].toString() + "i",
                    name: item["productname"],
                    price: item["price"],
                    image: item["image"],
                    packingType: item["packingtype"],
                    stock: item["stock"].toInt(),
                    description: item["productname"],
                  ));
                });
          } else {
            return const Text("No results");
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}

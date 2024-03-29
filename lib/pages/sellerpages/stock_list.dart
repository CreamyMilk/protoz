import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:proto/models/product.dart';
import 'package:proto/pages/sellerpages/get_products_futures.dart';
import 'package:proto/utils/type_extensions.dart';

const _startColumnWidth = 45.0;

class InventoryList extends StatefulWidget {
  const InventoryList({Key? key}) : super(key: key);

  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "tabFab",
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).pushNamed("/addProduct");
        },
        label: const Text(
          "New ",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_off,
              color: Colors.white,
            ),
          )
        ],
        title: (const Text("Current Stock",
            style: TextStyle(
              color: Colors.black,
            ))),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Stack(children: [
        Container(
            margin: const EdgeInsets.only(top: 16),
            height: MediaQuery.of(context).size.height * .9,
            child: FutureBuilder(
                future: getCurrentStock(),
                builder: (context, projectSnap) {
                  if (projectSnap.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (projectSnap.data == null) {
                    return const Center(
                        child: Text("Sadly you have no products"));
                  } else if (projectSnap.data != null) {
                    return ListView.builder(
                        itemCount: (projectSnap.data as List).length,
                        itemBuilder: (context, index) {
                          var item = (projectSnap.data as List)[index];
                          return ShoppingCartRow(
                            product: Product(
                              image: item["image"],
                              categoryID: item["categoryID"],
                              productID: item["ID"],
                              packingType: item["packingtype"],
                              description: item["description"],
                              name: item["productname"],
                              stock: item["stock"],
                              price: item["price"],
                            ),
                            quantity: item["stock"],
                            onPressed: () {},
                          );
                        });
                  } else {
                    return const Center(
                        child: Text("A Network Error has occured"));
                  }
                }))
      ])),
    );
  }
}

class ShoppingCartSummary extends StatelessWidget {
  const ShoppingCartSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final smallAmountStyle =
        Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.brown);
    final largeAmountStyle = Theme.of(context)
        .textTheme
        .headline4!
        .copyWith(color: Colors.green[900], letterSpacing: 0.0);
    // final formatter = NumberFormat.simpleCurrency(
    //   decimalDigits: 2,
    //   locale: Localizations.localeOf(context).toString(),
    // );

    return Row(
      children: [
        const SizedBox(width: _startColumnWidth),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 16),
            child: Column(
              children: [
                MergeSemantics(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "TOTAL",
                        style:
                            TextStyle(color: Colors.green[900], fontSize: 20),
                      ),
                      Expanded(
                          child: Text(
                        "\$\${storeP.totalPrice}",
                        style: largeAmountStyle,
                        textAlign: TextAlign.end,
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                MergeSemantics(
                  child: Row(
                    children: [
                      const Text("Subtotal:"),
                      Expanded(
                        child: Text(
                          "\$\${((storeP.totalPrice) * 0.95).toStringAsFixed(2)}",
                          style: smallAmountStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                MergeSemantics(
                  child: Row(
                    children: [
                      const Text("Shipping:"),
                      Expanded(
                        child: Text(
                          "\$\${((storeP.totalPrice) * 0.03).toStringAsFixed(2)}",
                          style: smallAmountStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                MergeSemantics(
                  child: Row(
                    children: [
                      const Text("Tax:"),
                      Expanded(
                        child: Text(
                          "\$\${((storeP.totalPrice) * 0.02).toStringAsFixed(2)}",
                          style: smallAmountStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ShoppingCartRow extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onPressed;

  const ShoppingCartRow(
      {Key? key,
      required this.product,
      required this.quantity,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/addProduct", arguments: product);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          key: ValueKey<int>(
              product.productID), //Changed Types for better parsing
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: _startColumnWidth,
              child: IconButton(
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.black,
                  size: 15,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/addProduct",
                      arguments: product);
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            color: Colors.white,
                            width: 70,
                            height: 70,
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: product.image,
                              height: 70,
                              width: 70,
                              placeholder: (context, String p) {
                                return Card(
                                    child: Container(
                                  height: 70,
                                  width: 70,
                                  color: Colors.grey[50],
                                ));
                              },
                            )
                            // excludeFromSemantics: true,
                            ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text("Quantity:  $quantity",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18)),
                                  ),
                                  Text(
                                    "x Ksh.${product.price.toString().addCommas}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              Text(
                                ":: ${product.name}  ::",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 9),
                              Text(
                                "Descrption:\n${product.description}",
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      color: Colors.brown,
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

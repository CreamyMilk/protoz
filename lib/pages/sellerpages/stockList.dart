import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:proto/pages/sellerpages/getProductsFutures.dart';
import 'package:proto/popups/changeQunatityPopup.dart';

const _startColumnWidth = 45.0;

class InventoryList extends StatefulWidget {
  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "tabFab",
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).pushNamed("/addProduct");
        },
        label: Text(
          "New ",
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_off,
              color: Colors.black,
            ),
          )
        ],
        title: Row(
          children: [
            Text(
              "Current Stock",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
            const SizedBox(width: 16),
            Text(
              "10 ITEMS",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 11),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
          child: Container(
        child: Stack(children: [
          Container(
              margin: EdgeInsets.only(top: 16),
              height: MediaQuery.of(context).size.height * .9,
              child: FutureBuilder(
                  future: getAllProducts(),
                  builder: (context, projectSnap) {
                    print(projectSnap.data);
                    if (projectSnap.connectionState == ConnectionState.none &&
                        projectSnap.hasData == null) {
                      //print('project snapshot data is: ${projectSnap.data}');
                      return Center(
                        child: Text("Sadly you have no products"),
                      );
                    } else {
                      return ListView.builder(
                         
                          itemCount: projectSnap.data.length,
                          itemBuilder: (context, index) {
                            var item = projectSnap.data[index];
                            return ShoppingCartRow(
                              product: Product(
                                imageURL:item["image"],
                                category: "1",
                                id: item["productID"],
                                isFeatured: true,
                                name: (_) {
                                  return item["productname"];
                                },
                                price: item["price"],
                              ),
                              quantity: 5,
                              onPressed: () {},
                            );
                          });
                    }
                  }))
        ]),
      )),
    );
  }
}

class ShoppingCartSummary extends StatelessWidget {
  const ShoppingCartSummary();

  @override
  Widget build(BuildContext context) {
    final smallAmountStyle =
        Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.brown);
    final largeAmountStyle = Theme.of(context)
        .textTheme
        .headline4
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
                      Text("Subtotal:"),
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
                      Text("Shipping:"),
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
                      Text("Tax:"),
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
  const ShoppingCartRow({
    @required this.product,
    @required this.quantity,
    this.onPressed,
  });

  final Product product;
  final int quantity;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // final formatter = NumberFormat.simpleCurrency(
    //   decimalDigits: 0,
    //   locale: Localizations.localeOf(context).toString(),
    // );
    Widget _buildPopupDialog(BuildContext context) {
      return ChangeQunatityPopUp();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        key: ValueKey<int>(product.id), //Changed Types for better parsing
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: _startColumnWidth,
            child: IconButton(
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.black,
                size: 15,
              ),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(context),
                );
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
                        color: Colors.pink,
                        width: 70,
                        height: 70,
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18)),
                                ),
                                Text(
                                  "x \$${product.price}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            Text(
                              product.name(context),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
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
    );
  }
}

class Product {
  const Product({
    @required this.category,
    @required this.id,
    @required this.imageURL,
    @required this.isFeatured,
    @required this.name,
    @required this.price,
    this.assetAspectRatio = 1,
  })  : assert(category != null),
        assert(id != null),
        assert(imageURL != null),
        assert(isFeatured != null),
        assert(name != null),
        assert(price != null),
        assert(assetAspectRatio != null);

  final String category;
  final int id;
  final String imageURL;
  final bool isFeatured;
  final double assetAspectRatio;

  // A function taking a BuildContext as input and
  // returns the internationalized name of the product.
  final String Function(BuildContext) name;

  final int price;
}

import 'package:cached_network_image/cached_network_image.dart';
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
        backgroundColor:Colors.white,
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
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_off,
              color: Colors.black,
            ),
          )
        ],
        
       title:(
            Text(
              "Current Stock",
              style: TextStyle(
                  color: Colors.black,
                  ))),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Container(
        child: Stack(children: [
          Container(
              margin: EdgeInsets.only(top: 16),
              height: MediaQuery.of(context).size.height * .9,
              child: FutureBuilder(
                  future: getCurrentStock(),
                  builder: (context, projectSnap) {
                    if (projectSnap.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if( 
                            projectSnap.data == null) {
                      return Center(child: Text("Sadly you have no products"));
                    } else if ( projectSnap.data != null) {
                      return ListView.builder(
                          itemCount: projectSnap.data.length,
                          itemBuilder: (context, index) {
                            var item = projectSnap.data[index];
                            return ShoppingCartRow(
                              product: Product(
                                imageURL: item["image"],
                                category: item["categoryID"],
                                id: item["productID"],
                                isFeatured: true,
                                description: item["description"],
                                name: (_) {
                                  return item["productname"];
                                },
                                price: item["price"].toDouble(),
                              ),
                              quantity: item["stock"],
                              onPressed: () {},
                            );
                          });
                    } else {
                      return Center(
                          child: Text("Classificataion of conncetion failed"));
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
                Navigator.of(context).pushNamed("/addProduct");
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
                            imageUrl: product.imageURL,
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
                            const SizedBox(height: 9),
                            Text(
                              product.description,
                              style: TextStyle(
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
    @required this.description,
    this.assetAspectRatio = 1,
  })  : assert(category != null),
        assert(id != null),
        assert(imageURL != null),
        assert(isFeatured != null),
        assert(name != null),
        assert(price != null),
        assert(assetAspectRatio != null);

  final int category;
  final int id;
  final String imageURL;
  final String description;
  final bool isFeatured;
  final double assetAspectRatio;

  // A function taking a BuildContext as input and
  // returns the internationalized name of the product.
  final String Function(BuildContext) name;

  final double price;
}

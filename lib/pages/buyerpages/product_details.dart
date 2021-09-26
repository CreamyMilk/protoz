import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proto/models/product.dart';
import 'package:proto/pages/buyerpages/buy_popup.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:proto/widgets/image_with_default.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.p}) : super(key: key);

  final Product p;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int totalPrice = 0;
  int quantity = 1;
  bool delivery = true;
  Widget _buildPopupDialog(BuildContext context) {
    return BuyProductPopup(
        acceptDelivery: delivery, p: widget.p, quantity: quantity);
  }

  @override
  void initState() {
    totalPrice = widget.p.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String totalString = totalPrice.toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
          heroTag: widget.p.heroName,
          backgroundColor: Colors.yellow,
          splashColor: Colors.white,
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context),
            );
          },
          label: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pay",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Text(
                  "Ksh. $totalString",
                  style: const TextStyle(fontSize: 22, color: Colors.black),
                ),
              ],
            ),
          )),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.p.name,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          const YMargin(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: widget.p.productID.toString() + "hero",
                child: ImgWithDefault(
                    imageDimension: screenWidth(context, percent: 0.5),
                    url: widget.p.image),
              ),
              Column(
                children: [
                  SizedBox(
                      width: 150,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(widget.p.name,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20)),
                            Text(widget.p.packingType),
                          ])),
                ],
              ),
              const XMargin(15),
            ],
          ),
          const YMargin(15),
          Column(
            children: [
              const Divider(),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quantity",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 22)),
                        const XMargin(3),
                        Row(children: [
                          FloatingActionButton(
                            splashColor: Colors.black,
                            heroTag: "sdfjdfkjdsf",
                            backgroundColor: Colors.yellow,
                            child:
                                const Icon(Icons.remove, color: Colors.black),
                            mini: true,
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity -= 1;
                                  totalPrice = widget.p.price * quantity;
                                });
                              }
                            },
                          ),
                          Container(
                              height: 50,
                              width: 70,
                              color: Colors.white60,
                              child: Center(
                                  child: Text(
                                "0$quantity",
                                style: const TextStyle(fontSize: 22),
                              ))),
                          FloatingActionButton(
                              splashColor: Colors.white,
                              heroTag: "dsfkjdsfkjdf",
                              backgroundColor: Colors.yellow,
                              child: const Icon(Icons.add, color: Colors.black),
                              mini: true,
                              onPressed: () {
                                if (quantity < widget.p.stock) {
                                  setState(() {
                                    quantity += 1;
                                    totalPrice = widget.p.price * quantity;
                                  });
                                }
                              }),
                        ]),
                        // SwitchListTile(value: false, onChanged: (bool me) {}),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Card(
                  child: ListTile(
                    dense: true,
                    visualDensity:
                        VisualDensity(horizontal: .001, vertical: .001),
                    //tileColor: Colors.pink,
                    onTap: () {},
                    title: Text("Delivery Cost",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 22)),
                    trailing: Switch(
                      activeColor: Colors.amber[900],
                      value: delivery,
                      onChanged: (bool value) {
                        setState(() {
                          delivery = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      totalString,
                      style: const TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}

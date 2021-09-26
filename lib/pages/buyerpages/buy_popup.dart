import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proto/models/product.dart';
import 'dart:ui';

import 'package:proto/pages/buyerpages/buy_product_future.dart';

class BuyProductPopup extends StatelessWidget {
  const BuyProductPopup({
    Key? key,
    required this.p,
    required this.quantity,
    required this.acceptDelivery,
  }) : super(key: key);
  final Product p;
  final int quantity;
  final bool acceptDelivery;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: CupertinoAlertDialog(
        title: const Text('Confirm Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Quantity: ($quantity) ${p.name}"),
            Text("Total:    Ksh.${p.price * quantity}")
          ],
        ),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Colors.red,
            child: const Text('Edit'),
          ),
          MaterialButton(
            onPressed: () {
              sendAddProductRequest(p, quantity, acceptDelivery);
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Purchase'),
          ),
        ],
      ),
    );
  }
}

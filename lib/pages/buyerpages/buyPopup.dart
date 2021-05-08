import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proto/models/product.dart';
import 'dart:ui';

import 'package:proto/pages/buyerpages/buyProductFuture.dart';

class BuyProductPopup extends StatelessWidget {
  const BuyProductPopup({
    Key key,
    @required this.p,
    @required this.quantity,
    @required this.acceptDelivery,
  }) : super(key: key);
  final Product p;
  final int quantity;
  final bool acceptDelivery;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: new CupertinoAlertDialog(
        title: const Text('Confirm Payment'),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[],
        ),
        actions: <Widget>[
          new MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Colors.red,
            child: const Text('Edit'),
          ),
          new MaterialButton(
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

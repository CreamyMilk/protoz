import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:proto/constants.dart';
import 'package:proto/main.dart';
import 'package:proto/models/product.dart';

Future sendAddProductRequest(Product p, int quantity, bool delivery) async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await post(
      Uri.parse(Constants.API_BASE + "invoice/create"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        //ensure that the user has bothe the socketID and the USER ID
        {
          "walletname": box.get(Constants.WalletNameStore),
          "productid": p.productID,
          "quantity": quantity,
          "passwordHash": "3423432",
          "acceptDelivery": delivery ? 1 : 0,
        },
      ),
    );
    var myjson = json.decode(response.body);
    if (myjson["status"] != 0) {
      showCupertinoDialog(
          context: navigatorKey.currentContext!,
          builder: (context) => AlertDialog(
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      textColor: Theme.of(context).primaryColor,
                      child: const Text('Close'),
                    ),
                  ],
                  title: const Text("Minor Issue"),
                  content: Text(myjson["message"])));
    } else {
      showCupertinoDialog(
          context: navigatorKey.currentContext!,
          builder: (context) => AlertDialog(
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      textColor: Theme.of(context).primaryColor,
                      child: const Text('Continue Shopping'),
                    ),
                  ],
                  title: const Text("Success"),
                  content: Text(myjson["message"])));
    }
  } catch (error) {
    // ignore: avoid_print
    print(error);
  }
}

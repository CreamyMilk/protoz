import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:proto/constants.dart';
import 'package:proto/models/product.dart';

Future sendAddProductRequest(Product p, int quantity, bool delivery) async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await post(
      ("http://34.125.117.7:3000/" + "invoice/create"),
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
    print(myjson);
  } catch (error) {
    print(error);
  }
}

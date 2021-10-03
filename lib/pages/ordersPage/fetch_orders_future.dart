import 'dart:convert';

//import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:proto/constants.dart';

Future getCurrentOrders() async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await post(
      Uri.parse(Constants.API_BASE + "invoice/due"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        //ensure that the user has bothe the socketID and the USER ID
        {
          "walletname": box.get(Constants.WalletNameStore),
        },
      ),
    );
    var myjson = json.decode(response.body);
    if (myjson["status"] == 0) {
      box.put(Constants.TotalOrdersStore, (myjson["total"]));
      box.put(Constants.OrdersListStore, myjson["orders"]);
    }
  } catch (err) {
//print("Brah no internert");
  }
}

Future<List>? getPurchases() async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await post(
      Uri.parse(Constants.API_BASE + "invoice/due"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        //ensure that the user has bothe the socketID and the USER ID
        {
          "walletname": box.get(Constants.WalletNameStore),
        },
      ),
    );
    var myjson = json.decode(response.body);
    if (myjson["status"] == 0) {
      return myjson["purchases"] as List;
    }
  } catch (err) {
    return [];
  }
  return [];
}

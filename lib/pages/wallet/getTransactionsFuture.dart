import 'dart:convert';

//import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:proto/constants.dart';

Future getLatestTransaction() async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await post(
      (Constants.API_BASE + "wallet/transactions"),
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
    print(myjson);
    if (myjson["status"] == 0) {
      box.put(Constants.TransactionsStore, myjson["transactions"]);
    }
  } catch (SocketException) {
    print("Brah no internert");
  }
}

Future getLatestBalance() async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await post(
      (Constants.API_BASE + "wallet/balance"),
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
      box.put(Constants.BalanceStore, myjson["balance"]);
    }
  } catch (SocketException) {
    print("Brah no internert");
  }
}

Future getCurrentOrders() async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await post(
      (Constants.API_BASE + "invoice/orders"),
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
      box.put(Constants.OrdersStore, myjson["total"]);
    }
  } catch (SocketException) {
    print("Brah no internert");
  }
}

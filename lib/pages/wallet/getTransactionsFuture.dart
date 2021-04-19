import 'dart:convert';

import 'package:proto/constants.dart' as Constants;
//import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

Future getLatestTransaction() async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await post(
      ("http://192.168.0.13:3000/" + "wallet/transactions"),
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
      box.put(Constants.TransactionsStore, myjson["transactions"]);
    }
  } catch (SocketException) {
    print("Brah no internert");
  }
}

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:proto/constants.dart';
import 'package:proto/models/past_purchase.dart';

Future<PastPurchasesResponse?> getPastPurchases() async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await post(
      Uri.parse(Constants.API_BASE + "invoice/placed"),
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
    PastPurchasesResponse resp;

    if (myjson["status"] == 0) {
      resp = PastPurchasesResponse.fromJson(myjson);
      return resp;
    }
  } catch (err) {
    return null;
  }
  return null;
}

Future<PastPurchasesResponse?> searchPastPurchases(String q) async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await post(
      Uri.parse(Constants.API_BASE + "invoice/search"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        //ensure that the user has bothe the socketID and the USER ID
        {
          "walletname": box.get(Constants.WalletNameStore),
          "query": q,
        },
      ),
    );
    var myjson = json.decode(response.body);
    PastPurchasesResponse resp;

    if (myjson["status"] == 0) {
      resp = PastPurchasesResponse.fromJson(myjson);
      return resp;
    }
  } catch (err) {
    return null;
  }
  return null;
}

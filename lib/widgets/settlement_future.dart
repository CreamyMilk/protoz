import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:proto/constants.dart';
import 'package:proto/main.dart';
import 'package:proto/popups/scanned_settlement.dart';

Future settleRequest(String settlemnetCode) async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await post(
      Uri.parse(Constants.API_BASE + "invoice/settle"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        {
          "code": settlemnetCode,
          "sellerid": box.get(Constants.UserIDStore),
        },
      ),
    );
    var myjson = json.decode(response.body);
    if (myjson["status"] == 0 && myjson["message"] as String != "") {
      showCupertinoDialog(
          context: navigatorKey.currentContext!,
          builder: (BuildContext context) =>
              ScannedSuccesfullyPopup(message: myjson["message"] as String));
    } else {
      showCupertinoDialog(
          context: navigatorKey.currentContext!,
          builder: (BuildContext context) =>
              FailedToSettleInvoice(message: myjson["message"] as String));
    }
  } catch (err) {
//print("Brah no internert");
  }
}

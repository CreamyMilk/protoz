import 'package:flutter/material.dart';
import 'package:proto/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proto/main.dart';

class DepositStruct {
  final String amount;
  final String walletName;
  final String phoneNumber;
  DepositStruct(
      {required this.amount,
      required this.walletName,
      required this.phoneNumber});
}

Future sendDepositRequest(DepositStruct dep) async {
  try {
    final response = await http.post(
      Uri.parse("${Constants.API_BASE}wallet/deposit"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        {
          'walletname': dep.walletName,
          'phonenumber': dep.phoneNumber,
          "fcmtoken": "notSet", // You can add this later
          'amount': dep.amount,
        },
      ),
    );
    dynamic myjson = json.decode(response.body);
    print(myjson);
    return myjson;
  } catch (err) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text("Error Sending the deposit request because $err"),
        action: SnackBarAction(
          label: "Close",
          onPressed: () {
            Navigator.of(navigatorKey.currentContext!).pop();
          },
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:proto/constants.dart' as Constants;

import 'package:hive/hive.dart';
import 'package:http/http.dart';

Future getCurrentStock() async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await post(
      ("http://192.168.0.13:3000/" + "store/stock"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        //ensure that the user has bothe the socketID and the USER ID
        {
          "ownerid": box.get(Constants.UserIDStore),
        },
      ),
    );
    var myjson = json.decode(response.body);
    if (myjson["status"] == 0) {
    return myjson["products"];
    }
  } catch (SocketException) {
    print("Brah no internert");
    return null;
  }
}

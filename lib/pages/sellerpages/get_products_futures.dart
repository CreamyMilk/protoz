import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:proto/constants.dart';

Future getCurrentStock() async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await post(
      Uri.parse(Constants.API_BASE + "store/stock"),
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
  } catch (err) {
//print("Brah no internert");
    return null;
  }
}

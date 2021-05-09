import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:proto/constants.dart';

Future getLatestCategories() async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await get(
      (Constants.API_BASE + "store/categories"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    var myjson = json.decode(response.body);
    if (myjson["status"] == 0) {
      box.put(Constants.ProductCategoriesStore, myjson["categories"]);
    }
  } catch (SocketException) {
    print("Brah no internert");
  }
}

Future getProductsList() async {
  var box = Hive.box(Constants.UserBoxName);
  try {
    final response = await post(
      (Constants.API_BASE + "store/products"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        //ensure that the user has bothe the socketID and the USER ID
        {
          "categoryid": box.get(Constants.ChoosenCategory),
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

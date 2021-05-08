import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

import 'package:proto/constants.dart' as Constants;

class AddProductFormProvider extends ChangeNotifier {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController packingController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();

  bool showError = false;
  bool loading = false;

  void clearAll() {
    descriptionController.clear();
    productNameController.clear();
    categoryController.clear();
    packingController.clear();
    imageController.clear();
    stockController.clear();
    priceController.clear();
  }

  Future sendAddProductRequest(BuildContext ctx) async {
    var box = Hive.box(Constants.UserBoxName);
    loading = true;
    notifyListeners();
    try {
      final response = await post(
        ("http://34.125.117.7:3000/" + "store/add"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode(
          //ensure that the user has bothe the socketID and the USER ID
          {
            "categoryID": int.parse(categoryController.text),
            "ownerID": box.get(Constants.UserIDStore),
            "productname": productNameController.text,
            "image": imageController.text,
            "imagelarge": imageController.text,
            "description": descriptionController.text,
            "packingtype": packingController.text,
            "stock": int.parse(stockController.text),
            "price": double.parse(priceController.text)
          },
        ),
      );
      var myjson = json.decode(response.body);
      print(myjson);
      if (myjson["status"] == 0) {
        loading = false;
        notifyListeners();
        clearAll();
      } else {
        loading = false;
        notifyListeners();
        //clearAll();
      }
    } catch (error) {
      print(error);
      loading = false;
      notifyListeners();
    }
  }
}

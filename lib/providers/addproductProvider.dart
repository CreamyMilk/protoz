import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

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

  void attemptLogin(BuildContext ctx) async {
    if (categoryController.text != "" && productNameController.text != "") {
      loading = true;
      showError = false;
      notifyListeners();
      sendAddProductRequest(ctx);
    } else {
      loading = false;
      showError = true;
      notifyListeners();
    }
  }

  Future sendAddProductRequest(BuildContext ctx) async {
    try {
      final response = await post(
        ("http://192.168.0.13:3000/" + "store/add"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode(
          //ensure that the user has bothe the socketID and the USER ID
          {
            "categoryID": 1,
            "ownerID": 1,
            "productname": "pridname",
            "image": "http://image",
            "imagelarge": "http://large",
            "description": "this descrioption is too long",
            "packingtype": "bottles",
            "stock": 100,
            "price": 2000.34
          },
        ),
      );
      var myjson = json.decode(response.body);
      if (myjson["status"] == 0) {
      } else {}
    } catch (SocketException) {
      loading = false;
      notifyListeners();
    }
  }
}

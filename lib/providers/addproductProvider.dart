import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:proto/constants.dart';
import 'package:proto/main.dart';
import 'package:proto/models/product.dart';

class AddProductFormProvider extends ChangeNotifier {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController packingController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();

  int categoryID;

  bool showError = false;
  bool loading = false;
  bool isEdit = false;
  Product globalProduct;

  void setCategory(int value) {
    categoryID = value;
    notifyListeners();
  }

  void clearAll() {
    descriptionController.clear();
    productNameController.clear();
    categoryController.clear();
    packingController.clear();
    imageController.clear();
    stockController.clear();
    priceController.clear();
    categoryID = null;
  }

  void initalizeEditFields(Product p) {
    globalProduct = p;
    isEdit = true;
    descriptionController.text = p.description;
    productNameController.text = p.name;
    categoryID = p.categoryID;
    packingController.text = p.packingType;
    imageController.text = p.image;
    stockController.text = p.stock.toString();
    priceController.text = p.price.toString();
  }

  Future sendAddProductRequest(BuildContext ctx) async {
    var box = Hive.box(Constants.UserBoxName);
    loading = true;
    notifyListeners();
    try {
      final response = await (isEdit ? put : post)(
        (Constants.API_BASE + (isEdit ? "store/update" : "store/add")),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode(
          //ensure that the user has bothe the socketID and the USER ID
          {
            "categoryID": categoryID,
            "productID": isEdit ? globalProduct.productID : null,
            "ownerID": box.get(Constants.UserIDStore),
            "productname": productNameController.text,
            "image": imageController.text,
            "imagelarge": imageController.text,
            "description": descriptionController.text,
            "packingtype": packingController.text,
            "stock": int.parse(stockController.text),
            "price": int.parse(priceController.text)
          },
        ),
      );
      var myjson = json.decode(response.body);
      print(myjson);
      if (myjson["status"] == 0) {
        print(myjson);
        loading = false;
        notifyListeners();
        clearAll();
      } else {
        loading = false;
        showCupertinoDialog(
            context: navigatorKey.currentContext,
            builder: (context) => AlertDialog(
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        textColor: Theme.of(context).primaryColor,
                        child: const Text('Close'),
                      ),
                    ],
                    title: Text("Minor Issue."),
                    content: Text(myjson["message"])));
        notifyListeners();
        //clearAll();
      }
    } catch (error) {
      showCupertinoDialog(
        context: navigatorKey.currentContext,
        builder: (context) => AlertDialog(
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              textColor: Theme.of(context).primaryColor,
              child: const Text('Close'),
            ),
          ],
          title: Text("Error in the Form"),
          content: Text(
            "[RESOLVE]:$error",
          ),
        ),
      );
      loading = false;
      notifyListeners();
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proto/popups/addProdPopup.dart';
//import 'package:proto/providers/addproductProvider.dart';
import 'package:proto/utils/sizedMargins.dart';
//import 'package:provider/provider.dart';

class AddProductsPage extends StatelessWidget {
  Widget _buildPopupDialog(BuildContext context) {
    return AppProductPopUp();
  }

  @override
  Widget build(BuildContext context) {
    ////final hbox = Provider.of<AddProductFormProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lightGreen,
        shape: RoundedRectangleBorder(),
        onPressed: () {
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        },
        label: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sumbit",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.remove_done,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
        title: Text("Product Entry"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            ////key: hbox.productFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                    decoration: InputDecoration(
                  labelText: "Category",
                  hintText: "Catergory",
                  border: OutlineInputBorder(),
                )),
                const YMargin(10),
                TextField(
                    decoration: InputDecoration(
                  labelText: "Product Name",
                  hintText: "Product Name",
                  border: OutlineInputBorder(),
                )),
                const YMargin(10),
                TextField(
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.camera_alt_outlined),
                      labelText: "Image src",
                      hintText: "Image url",
                      border: OutlineInputBorder(),
                    )),
                SizedBox(
                  height: 10,
                ),
                Branding(),
                const YMargin(10),
                TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Price",
                      hintText: "Price",
                      border: OutlineInputBorder(),
                    )),
                const YMargin(10),
                TextField(
                    decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Description",
                  border: OutlineInputBorder(),
                )),
                const YMargin(80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Branding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        SizedBox(width: 5),
        Flexible(
          flex: 2,
          child: TextFormField(
            keyboardType: TextInputType.datetime,
            validator: (value) {
              if (value.isEmpty) {
                return "Required";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Product Name',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal)),
            ),
            maxLines: 1,
          ),
        ),
        SizedBox(width: 25),
        Flexible(
          flex: 2,
          child: TextFormField(
            keyboardType: TextInputType.datetime,
            validator: (value) {
              if (value.isEmpty) {
                return "Required";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'BrandName',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal)),
            ),
            maxLines: 1,
          ),
        ),
        SizedBox(width: 5),
      ]),
    );
  }
}

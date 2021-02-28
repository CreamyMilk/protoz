import 'package:flutter/material.dart';
import 'package:proto/widgets/popups/addProdPopup.dart';

class AddProductsPage extends StatelessWidget {
  Widget _buildPopupDialog(BuildContext context) {
    return AppProductPopUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          showDialog(
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
        leading: Container(),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
                decoration: InputDecoration(
              labelText: "Category",
              hintText: "Catergory",
              border: OutlineInputBorder(),
            )),
            TextField(
                decoration: InputDecoration(
              labelText: "Sub Category",
              hintText: "Sub Category",
              border: OutlineInputBorder(),
            )),
            TextField(
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  labelText: "Image SRC",
                  hintText: "Imag URL",
                  border: OutlineInputBorder(),
                )),
            SizedBox(
              height: 10,
            ),
            Branding(),
            TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Price",
                  hintText: "Price",
                  border: OutlineInputBorder(),
                )),
            TextField(
                decoration: InputDecoration(
              labelText: "Description",
              hintText: "Description",
              border: OutlineInputBorder(),
            )),
            SizedBox(height: 100),
          ],
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

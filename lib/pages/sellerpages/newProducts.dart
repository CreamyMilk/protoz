import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proto/providers/addproductProvider.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:provider/provider.dart';

class AddProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hbox = Provider.of<AddProductFormProvider>(context);
    return Scaffold(
        backgroundColor:Colors.white,
        floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat ,
      floatingActionButton:hbox.loading?CircularProgressIndicator(): FloatingActionButton.extended(
        backgroundColor: Colors.lightGreen,
        shape: RoundedRectangleBorder(),
        onPressed: () {
          hbox.sendAddProductRequest(context);
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
          foregroundColor: Colors.black,
          elevation:0,
          iconTheme: IconThemeData(
                  color: Colors.white,
                    ),
        backgroundColor:Colors.teal,
        centerTitle: true,
        actions: [
        GestureDetector(onTap:(){
          hbox.clearAll();
        }, child:Padding(padding:EdgeInsets.all(8.0),child:Center(child: Text("Clear"),),),),
        ],
        title: Text("New Product Entry",style: TextStyle(color:Colors.white)),

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
                    controller: hbox.categoryController,
                     keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Category",
                      hintText: "Catergory",
                      border: OutlineInputBorder(),
                    )),
                const YMargin(15),
                TextField(
                     keyboardType: TextInputType.text,
                    controller: hbox.productNameController,
                    decoration: InputDecoration(
                      labelText: "Product Name",
                      hintText: "Product Name",
                      border: OutlineInputBorder(),
                    )),
                const YMargin(15),
                TextField(
                    controller: hbox.imageController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.camera_alt_outlined),
                      labelText: "Image src",
                      hintText: "Image url",
                      border: OutlineInputBorder(),
                    )),
                const YMargin(15),
                TextField(
                    controller: hbox.packingController,
                     keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Packing Type",
                      hintText: "Packing Type",
                      border: OutlineInputBorder(),
                    )),
                const YMargin(15),
                TextField(
                    controller: hbox.stockController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Stock",
                      hintText: "Stock",
                      border: OutlineInputBorder(),
                    )),
                const YMargin(15),
                TextField(
                    controller: hbox.priceController,
                    keyboardType: TextInputType.numberWithOptions(decimal:true),
                    decoration: InputDecoration(
                      labelText: "Price",
                      hintText: "Price",
                      border: OutlineInputBorder(),
                    )),
                const YMargin(15),
                TextField(
                    controller: hbox.descriptionController,
                     keyboardType: TextInputType.text,
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

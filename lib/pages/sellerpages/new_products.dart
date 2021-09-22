import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:proto/constants.dart';
import 'package:proto/models/product.dart';
import 'package:proto/providers/addproduct_provider.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:provider/provider.dart';

class AddProductsPage extends StatefulWidget {
  final Product? initalProduct;

  const AddProductsPage({Key? key, this.initalProduct}) : super(key: key);
  @override
  _AddProductsPageState createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  dynamic box = Hive.box(Constants.UserBoxName);
  List<DropdownMenuItem<int>> temp = [];

  bool isLoaded = false;
  @override
  void initState() {
    dynamic c = box.get(Constants.ProductCategoriesStore).toList();
    isLoaded = false;
    c.forEach((t) {
      print(t);
      temp.add(DropdownMenuItem<int>(
        value: t["categoryid"],
        child: Text(t["categoryname"]),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hbox = Provider.of<AddProductFormProvider>(context);
    if (widget.initalProduct != null && !isLoaded) {
      hbox.initalizeEditFields(widget.initalProduct!);
      isLoaded = true;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.green[700],
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              hbox.clearAll();
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Clear All ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white60,
                  ),
                ),
              ),
            ),
          ),
        ],
        title: Text(hbox.isEdit ? "Edit Product" : "New Product Entry",
            style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            ////key: hbox.productFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    hbox.isEdit
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              transformAlignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                              ),
                              height: 85,
                              width: 85,
                              child: Image.network(hbox.imageController.text,
                                  fit: BoxFit.scaleDown),
                            ),
                          )
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        transformAlignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                        ),
                        height: 85,
                        width: 85,
                        child: Icon(Icons.add, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const YMargin(10),
                DropdownButtonFormField(
                  elevation: 1,
                  items: temp,
                  decoration: InputDecoration(
                    labelText: "Category",
                    hintText: "Catergory",
                    border: OutlineInputBorder(),
                  ),
                  value: hbox.categoryID,
                  onChanged: (value) {
                    hbox.categoryController.text = value.toString();
                    hbox.setCategory(value as int);
                  },
                ),
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
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    controller: hbox.stockController,
                    decoration: InputDecoration(
                      labelText: "Stock",
                      hintText: "Stock",
                      border: OutlineInputBorder(),
                    )),
                const YMargin(15),
                TextField(
                    controller: hbox.priceController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
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
                const YMargin(100),
                hbox.loading
                    ? CircularProgressIndicator()
                    : FloatingActionButton.extended(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(),
                        onPressed: () {
                          hbox.sendAddProductRequest(context);
                        },
                        label: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Submit",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
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
        const SizedBox(width: 5),
        Flexible(
          flex: 2,
          child: TextFormField(
            keyboardType: TextInputType.datetime,
            validator: (value) {
              if (value!.isEmpty) {
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
              if (value!.isEmpty) {
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
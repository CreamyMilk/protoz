import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proto/constants.dart';
import 'package:proto/models/product.dart';
import 'package:proto/pages/buyerpages/getCategoriesFuture.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black87,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: Hive.box(Constants.UserBoxName).listenable(),
          builder: (BuildContext context, box, child) {
            dynamic c = box.get(Constants.ProductCategoriesStore);
            dynamic categoryID = box.get(Constants.ChoosenCategory);
            String title = "No Category Name";
            for (int i = 0; i < c.length; i++) {
              print(categoryID);
              if (c[i]["categoryid"] == categoryID) {
                title = (c[i]["categoryname"]);
              }
            }
            return Text("$title", style: TextStyle(color: Colors.black87));
          },
        ),
      ),
      body: FutureBuilder(
          future: getProductsList(),
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (projectSnap.data == null) {
              return Center(child: Text("Sadly you have no products"));
            } else if (projectSnap.data != null) {
              return ListView.builder(
                  itemCount: projectSnap.data.length,
                  itemBuilder: (context, index) {
                    var item = projectSnap.data[index];
                    print(item);
                    return ProductListItem(
                        p: Product(
                      categoryID: item["categoryid"], //Confirm
                      productID: item["productID"],
                      heroName: item["productID"].toString() + "i",
                      name: item["productname"],
                      price: item["price"],
                      image: item["image"],
                      packingType: item["packingtype"],
                      stock: item["stock"].toInt(),
                      description: item["productname"],
                    ));
                  });
            } else {
              return Center(
                  child: Text("Classificataion of could not get product"));
            }
          }),
    );
  }
}

class ProductListItem extends StatelessWidget {
  final Product p;
  const ProductListItem({
    Key key,
    @required this.p,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        height: 150,
        width: MediaQuery.of(context).size.width * .9,
        color: Colors.white70,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/pdetails", arguments: p);
              },
              child: Hero(
                tag: p.productID.toString() + "hero",
                child: CachedNetworkImage(
                  imageUrl: p.image,
                  width: 150,
                  // color: Colors.pink,
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "${p.name}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "${p.packingType}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Ksh.",
                              style: TextStyle(
                                  color: Colors.deepPurple[200],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13)),
                          TextSpan(
                            text: "${p.price}",
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          )
                        ])),
                    Spacer(),
                    Hero(
                      tag: p.heroName,
                      child: MaterialButton(
                        color: Colors.green[300],
                        onPressed: () {
                          Navigator.pushNamed(context, "/pdetails",
                              arguments: p);
                        },
                        child: Text(
                          "Buy",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

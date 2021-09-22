import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proto/constants.dart';
import 'package:proto/models/product.dart';
import 'package:proto/pages/buyerpages/get_categories_future.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:proto/utils/type_extensions.dart';

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
          builder: (BuildContext context, Box<dynamic> box, child) {
            dynamic c = box.get(Constants.ProductCategoriesStore);
            dynamic categoryID = box.get(Constants.ChoosenCategory);
            String title = "No Category Name";
            for (int i = 0; i < c.length; i++) {
              print(categoryID);
              if (c[i]["categoryid"] == categoryID) {
                title = (c[i]["categoryname"]);
              }
            }
            return Text(title, style: TextStyle(color: Colors.black87));
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
              return const Center(child: Text("Sadly you have no products"));
            } else if (projectSnap.data != null) {
              return ListView.builder(
                  itemCount: (projectSnap.data as List).length,
                  itemBuilder: (context, index) {
                    var item = (projectSnap.data as List)[index];
                    return ProductListItem(
                        p: Product(
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
              return const Center(
                  child: Text("Classificataion of could not get product"));
            }
          }),
    );
  }
}

class ProductListItem extends StatelessWidget {
  final Product p;
  const ProductListItem({
    Key? key,
    required this.p,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double imageDimension = 100;
    double cardSize = 110;
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        height: cardSize,
        width: screenWidth(context, percent: 0.9),
        color: Colors.white70,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/pdetails", arguments: p);
                },
                child: Hero(
                  tag: p.productID.toString() + "hero",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      errorWidget:
                          (BuildContext ctx, String word, dynamic anything) {
                        return Image.network(
                            Constants.getProductPlaceHolderURL(),
                            width: imageDimension,
                            height: imageDimension);
                      },
                      imageUrl: p.image,
                      width: imageDimension,
                      height: imageDimension,
                      // color: Colors.pink,
                    ),
                  ),
                ),
              ),
            ),
            const XMargin(10),
            Container(
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        p.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        p.packingType,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                      ),
                    ),
                    const YMargin(5),
                    Expanded(
                      child: Row(
                        children: [
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
                                  text: p.price.toString().addCommas,
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                )
                              ])),
                          Spacer(),
                          Hero(
                            tag: p.heroName!,
                            child: MaterialButton(
                              color: Colors.green[700],
                              onPressed: () {
                                Navigator.pushNamed(context, "/pdetails",
                                    arguments: p);
                              },
                              child: Text(
                                "Buy ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proto/pages/buyerpages/getCategoriesFuture.dart';

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
        title: Text("Ferterlizers", style: TextStyle(color: Colors.black87)),
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
                      image: item["image"],
                      productID: item["productID"],
                        heroName: item["productname"],
                      buttonHero: item["productID"].toString()+"i",
                      packingType: item["packingtype"],
                      price: item["price"].toDouble()
                    );
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
  final String heroName;
  final String buttonHero;
  final int productID;
  final String image;
  final String packingType;
  final double price;
  const ProductListItem(
      {Key key,
      @required this.productID,
      @required this.heroName,
      @required this.image,
      @required this.packingType,
      @required this.price,
      @required this.buttonHero})
      : super(key: key);
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
                Navigator.of(context).pushNamed("/pdetails");
              },
              child: Hero(
                tag: heroName+productID.toString(),
                child: CachedNetworkImage(
                  imageUrl: image,
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
                        "$heroName",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "$packingType",
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
                            text: "$price",
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          )
                        ])),
                    Spacer(),
                    Hero(
                      tag: buttonHero,
                      child: MaterialButton(
                        color: Colors.green[300],
                        onPressed: () {
                          Navigator.of(context).pushNamed("/pdetails");
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

import 'package:flutter/material.dart';

class Service {
  final String imageUrl;
  final String name;

  Service({this.imageUrl, this.name});
}

class ListProducts extends StatefulWidget {
  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  List<dynamic> choices;
  List<Service> sampleData = [
    Service(
        imageUrl:
            "https://africasustainabilitymatters.com/wp-content/uploads/2020/11/Twiga_2.jpg",
        name: "InputSuppliers"),
    Service(
        imageUrl:
            "https://s3.amazonaws.com/newhobbyfarms.com/2020/01/9-plows-jeff-piper-flickr-e.jpg",
        name: "Machinery"),
    Service(
        imageUrl:
            "https://hingemarketing.com/wp-content/uploads/2017/08/B2B-Market-Research.png",
        name: "Market Info"),
    Service(
        imageUrl:
            "https://www.michiganstateuniversityonline.com/wp-content/uploads/sites/3/2014/04/logistics-fundamentals-supply-chain.jpg",
        name: "Logistics"),
    Service(
        imageUrl:
            "https://asmtech.com/wp-content/uploads/2018/03/What-we-do-_-Consultancy-1024x683.jpeg",
        name: "Consoltancy"),
    Service(
        imageUrl:
            "https://www.who.int/images/default-source/departments/health-financing/health-financing-and-uhc-(8).tmb-1200v.jpg?sfvrsn=add44264_6",
        name: "Financing"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Text("Welcome Oliver"),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 4,
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8),
                padding: EdgeInsets.all(8.0),
                itemCount: sampleData.length,
                itemBuilder: (context, index) {
                  return ProductListingItem(
                    heros: index,
                    prodname: sampleData[index].name,
                    imageUrl: sampleData[index].imageUrl,
                    productID: index,
                  );
                }),
          ),
        ],
      ),
    ));
  }
}

class ProductListingItem extends StatelessWidget {
  const ProductListingItem(
      {Key key,
      @required this.prodname,
      @required this.imageUrl,
      @required this.productID,
      @required this.heros})
      : super(key: key);
  final String prodname;
  final String imageUrl;
  final int productID;
  final int heros;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.21,
            color: Colors.transparent,
            child: Image.network(
              imageUrl,
              fit: BoxFit.fill,
              loadingBuilder: (context, child, progress) {
                return progress == null ? child : LinearProgressIndicator();
              },
            )),
      ),
      Spacer(),
      Text(prodname, style: TextStyle(fontWeight: FontWeight.bold)),
    ]);
  }
}

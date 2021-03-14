import 'package:flutter/material.dart';

class Services {
  final String imageUrl;
  final String name;

  Services({this.imageUrl, this.name});
}

class ListProducts extends StatefulWidget {
  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  List<dynamic> choices;
  List<Services> sampleData = [
    Services(
        imageUrl:
            "https://africasustainabilitymatters.com/wp-content/uploads/2020/11/Twiga_2.jpg",
        name: "InputSuppliers"),
    Services(
        imageUrl:
            "https://s3.amazonaws.com/newhobbyfarms.com/2020/01/9-plows-jeff-piper-flickr-e.jpg",
        name: "Machinery"),
    Services(
        imageUrl:
            "https://hingemarketing.com/wp-content/uploads/2017/08/B2B-Market-Research.png",
        name: "Market Info"),
    Services(
        imageUrl:
            "https://www.michiganstateuniversityonline.com/wp-content/uploads/sites/3/2014/04/logistics-fundamentals-supply-chain.jpg",
        name: "Logistics"),
    Services(
        imageUrl:
            "https://asmtech.com/wp-content/uploads/2018/03/What-we-do-_-Consultancy-1024x683.jpeg",
        name: "Consoltancy"),
    Services(
        imageUrl:
            "https://www.who.int/images/default-source/departments/health-financing/health-financing-and-uhc-(8).tmb-1200v.jpg?sfvrsn=add44264_6",
        name: "Financing"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          mini: true,
          child: Icon(
            Icons.bar_chart_sharp,
            color: Colors.white,
          ),
          foregroundColor: Colors.black87,
          heroTag: "jalo",
          onPressed: () {},
        ),
        body: SafeArea(
          child: HomeGrid(sampleData: sampleData),
        ));
  }
}

class HomeGrid extends StatelessWidget {
  const HomeGrid({
    Key key,
    @required this.sampleData,
  }) : super(key: key);

  final List<Services> sampleData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.95,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 0.5,
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 0.1),
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
    );
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
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed("/categories");
        },
        child: Card(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            color: Colors.black54,
          ),
          // child: Image.network(
          //   imageUrl,
          //   fit: BoxFit.fill,
          //   loadingBuilder: (context, child, progress) {
          //     return progress == null ? child : Container();
          //   },
          // )),
        ),
      ),
      Text(prodname,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0)),
    ]);
  }
}

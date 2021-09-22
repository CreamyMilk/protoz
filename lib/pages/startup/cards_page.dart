import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proto/pages/homeDash/photo_grid_tile.dart';

class Services {
  final String imageUrl;
  final String name;
  final String path;

  Services({required this.imageUrl, required this.name, required this.path});
}

class ListProducts extends StatefulWidget {
  const ListProducts({Key? key}) : super(key: key);

  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  late List<dynamic> choices;
  List<Services> sampleData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          mini: true,
          child: const Icon(
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
    Key? key,
    required this.sampleData,
  }) : super(key: key);

  final List<Services> sampleData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.95,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 0.5,
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 0.1),
              padding: const EdgeInsets.all(8.0),
              itemCount: sampleData.length,
              itemBuilder: (context, index) {
                return PhotoGridTile(
                  prodname: sampleData[index].name,
                  imageUrl: sampleData[index].imageUrl,
                  productID: index,
                  route: '',
                );
              }),
        ),
      ],
    );
  }
}

class ProductListingItem extends StatelessWidget {
  const ProductListingItem(
      {Key? key,
      required this.prodname,
      required this.imageUrl,
      required this.productID,
      required this.heros})
      : super(key: key);
  final String prodname;
  final String imageUrl;
  final int productID;
  final int heros;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("/categories");
            },
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fitWidth,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.95,
              placeholder: (context, String p) {
                return Card(
                    child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  color: Colors.grey[50],
                ));
              },
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(prodname,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0)),
          ),
        ),
      ]),
    );
  }
}

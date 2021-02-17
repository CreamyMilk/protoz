import 'package:flutter/material.dart';

class ListTilezz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InputSuppliers"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTileNew(
              routeName: "/ferter",
              name: "Fertilizers",
              imageUrl:
                  "https://burgerfarms.com/wp-content/gallery/fertilizers-plant-food/Organic-Fertilizers.JPG",
            ),
            SizedBox(
              height: 1,
            ),
            ListTileNew(
              routeName: "/seds",
              name: "Seeds",
              imageUrl:
                  "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
            ),
          ],
        ),
      ),
    );
  }
}

class ListTileNew extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String routeName;

  const ListTileNew(
      {Key key,
      @required this.imageUrl,
      @required this.name,
      @required this.routeName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(routeName);
            },
            child: Image.network(
              imageUrl,
              width: MediaQuery.of(context).size.width * 0.5,
              height: 150,
            ),
          ),
        ),
        SizedBox(width: 30),
        Text(name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 25.0)),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}

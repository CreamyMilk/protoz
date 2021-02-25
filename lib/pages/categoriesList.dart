import 'package:flutter/material.dart';

class ListTilezz extends StatelessWidget {
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
      appBar: AppBar(
        title: Text("InputSuppliers"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTileNew(
                barColor: Colors.orange,
                gradient: Colors.deepOrange,
                routeName: "/ferter",
                name: "Fertilizers",
                imageUrl:
                    "https://burgerfarms.com/wp-content/gallery/fertilizers-plant-food/Organic-Fertilizers.JPG",
              ),
              SizedBox(
                height: 1,
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent,
                routeName: "/seds",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent,
                routeName: "/seds",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent,
                routeName: "/seds",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent,
                routeName: "/seds",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.lightBlue,
                gradient: Colors.lightBlue,
                routeName: "/seds",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.lightBlueAccent,
                gradient: Colors.lightBlueAccent,
                routeName: "/seds",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent,
                routeName: "/seds",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent,
                routeName: "/seds",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.blue,
                gradient: Colors.blue,
                routeName: "/seds",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent,
                routeName: "/seds",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent,
                routeName: "/seds",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListTileNew extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String routeName;
  final Color barColor;
  final Color gradient;
  const ListTileNew(
      {Key key,
      @required this.imageUrl,
      @required this.name,
      @required this.routeName,
      @required this.barColor,
      @required this.gradient})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
        print("Zukes");
      },
      child: Container(
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.centerLeft,
              colors: [gradient, Colors.white]),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              color: barColor,
              width: 2,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: Image.network(
                imageUrl,
                width: 50,
                height: 50,
              ),
            ),
            SizedBox(width: 20),
            Column(
              children: [
                Text(name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 25.0)),
                Text("Description")
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Spacer(),
            Radio(value: false, groupValue: null, onChanged: (bool p) {})
          ],
        ),
      ),
    );
  }
}

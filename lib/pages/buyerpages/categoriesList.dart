import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proto/widgets/awesomeFab.dart';

class ListTilezz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AwesomeFab(),
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back),color:Colors.black87, onPressed: () { Navigator.of(context).pop(); },),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("InputSuppliers",style: TextStyle(color: Colors.black87),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTileNew(
                barColor: Colors.orange,
                gradient: Colors.deepOrange[100],
                routeName: "/products",
                name: "Fertilizers",
                imageUrl:
                    "https://burgerfarms.com/wp-content/gallery/fertilizers-plant-food/Organic-Fertilizers.JPG",
              ),
              SizedBox(
                height: 1,
             ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent[100],
                routeName: "/products",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent[100],
                routeName: "/products",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent,
                routeName: "/products",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent,
                routeName: "/products",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.lightBlue,
                gradient: Colors.lightBlue,
                routeName: "/products",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.lightBlueAccent,
                gradient: Colors.lightBlueAccent,
                routeName: "/products",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent,
                routeName: "/products",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent,
                routeName: "/products",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.blue,
                gradient: Colors.blue,
                routeName: "/products",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent,
                routeName: "/products",
                name: "Seeds",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              ListTileNew(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent,
                routeName: "/products",
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
    return Container(
      
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.centerLeft,
            colors: [gradient, Colors.white]),
      ),
      child: InkWell(
         onTap: () {
      Navigator.of(context).pushNamed(routeName);
      print("Zukes");
    },
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              color: barColor,
              width: 3,
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: CachedNetworkImage(
      imageUrl:imageUrl,
                width: 60,
                height: 60,
              
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
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
            Radio(
                activeColor: Colors.white,
                value: false,
                groupValue: null,
                onChanged: (bool p) {})
          ],
        ),
      ),
    );
  }
}

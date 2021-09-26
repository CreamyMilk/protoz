import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proto/utils/sizedMargins.dart';

class BLConsoltantsList extends StatelessWidget {
  const BLConsoltantsList({Key? key}) : super(key: key);

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
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Consulting"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BLConsoltantsTile(
                barColor: Colors.orange,
                gradient: Colors.deepOrange[100]!,
                routeName: "/blvets",
                name: "Vets",
                imageUrl:
                    "https://burgerfarms.com/wp-content/gallery/fertilizers-plant-food/Organic-Fertilizers.JPG",
              ),
              const YMargin(1),
              BLConsoltantsTile(
                barColor: Colors.greenAccent,
                gradient: Colors.greenAccent[100]!,
                routeName: "/blvets",
                name: "Extension Offers",
                imageUrl:
                    "https://st2.depositphotos.com/1177973/7724/i/950/depositphotos_77245988-stock-photo-female-hand-with-fertilizer-for.jpg",
              ),
              BLConsoltantsTile(
                barColor: Colors.greenAccent,
                gradient: Colors.blueAccent[100]!,
                routeName: "/blvets",
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

class BLConsoltantsTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String routeName;
  final Color barColor;
  final Color gradient;
  const BLConsoltantsTile(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.routeName,
      required this.barColor,
      required this.gradient})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
        print("Zukes");
      },
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        padding: const EdgeInsets.all(8),
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
              margin: const EdgeInsets.only(right: 10),
              color: barColor,
              width: 3,
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 50,
                height: 50,
              ),
            ),
            const XMargin(20),
            Column(
              children: [
                Text(name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 25.0)),
                const Text("Description")
              ],
            ),
            const XMargin(10),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

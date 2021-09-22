import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proto/constants.dart';
import 'package:proto/pages/buyerpages/get_categories_future.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:proto/widgets/awesomeFab.dart';

class ListTilezz extends StatefulWidget {
  const ListTilezz({Key? key}) : super(key: key);

  @override
  _ListTilezzState createState() => _ListTilezzState();
}

class _ListTilezzState extends State<ListTilezz> {
  @override
  void initState() {
    getLatestCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AwesomeFab(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              print("Seraching");
            },
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: screenHeight(context, percent: 0.9),
          child: ValueListenableBuilder(
              valueListenable: Hive.box(Constants.UserBoxName).listenable(),
              builder: (BuildContext context, Box<dynamic> box, child) {
                dynamic c = box.get(Constants.ProductCategoriesStore);
                return ListView.builder(
                    itemCount: c.length,
                    itemBuilder: (BuildContext context, int index) {
                      dynamic category = c[index];
                      return ListTileNew(
                          barColor: Colors.greenAccent,
                          gradient: Colors.greenAccent[100]!,
                          categoryId: category["categoryid"],
                          routeName: "/products",
                          name: category["categoryname"],
                          imageUrl: category["image"]);
                    });
              }),
        ),
      ),
    );
  }
}

class ListTileNew extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String routeName;
  final int categoryId;
  final Color barColor;
  final Color gradient;
  const ListTileNew(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.categoryId,
      required this.routeName,
      required this.barColor,
      required this.gradient})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey[400]!.withOpacity(0.3),
              offset: Offset(0, 13),
              blurRadius: 30)
        ],
        // borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.centerLeft,
            colors: const [Colors.white70, Colors.white]),
      ),
      child: InkWell(
        onTap: () {
          var box = Hive.box(Constants.UserBoxName);
          box.put(Constants.ChoosenCategory, categoryId);
          Navigator.of(context).pushNamed(routeName);
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
                imageUrl: imageUrl,
                width: 60,
                height: 60,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(width: 20),
            Text(name,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 25.0)),
            SizedBox(
              width: 10,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

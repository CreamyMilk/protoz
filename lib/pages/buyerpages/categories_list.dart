import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proto/constants.dart';
import 'package:proto/pages/buyerpages/get_categories_future.dart';
import 'package:proto/pages/buyerpages/search_page.dart';
import 'package:proto/utils/sized_margins.dart';
import 'package:proto/widgets/awesome_fab.dart';

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
      floatingActionButton: const AwesomeFab(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(context: context, delegate: ProductSearchDelegate());
            },
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
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
                          categoryId: category["ID"],
                          routeName: "/products",
                          name: category["CatergoryName"],
                          imageUrl: category["CatergoryImage"]);
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
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey[400]!.withOpacity(0.3),
              offset: const Offset(0, 13),
              blurRadius: 30)
        ],
        // borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.centerLeft,
            colors: [Colors.white70, Colors.white]),
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
              margin: const EdgeInsets.only(right: 10),
              color: barColor,
              width: 3,
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: imageUrl,
                width: 60,
                height: 60,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const XMargin(20),
            Text(name,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 25.0)),
            const XMargin(10),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

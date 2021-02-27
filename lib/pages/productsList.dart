import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ProductListItem(),
          // ProductListItem(),
          // ProductListItem(),
          // ProductListItem(),
          // ProductListItem(),
          // ProductListItem(),
          // ProductListItem(),
          // ProductListItem(),
          // ProductListItem(),
          // ProductListItem()
        ],
      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
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
                tag: "fert",
                child: Image.network(
                  "https://images.orgill.com/large/7615198.JPG",
                  width: 150,
                  // color: Colors.pink,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              // color: Colors.yellow,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Simple Product Name",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    "Simple Marketing/Packing",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "\$.48.20",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                  ),
                  Spacer(),
                  Hero(
                    tag: "fe",
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
            )
          ],
        ),
      ),
    );
  }
}

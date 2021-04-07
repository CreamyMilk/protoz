import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back),color:Colors.black87, onPressed: () { Navigator.of(context).pop(); },),
  actions: [IconButton(icon:Icon(Icons.search), onPressed: () {  },)],
        elevation: 1,
       backgroundColor:Colors.white,
        centerTitle:true,
        title:Text("Ferterlizers",style:TextStyle(color:Colors.black87)),
      ),
      body: ListView(
        children: [
          ProductListItem(heroName: "fert", buttonHero: "fer"),
          ProductListItem(heroName: "feewret", buttonHero: "fwererer"),
          ProductListItem(heroName: "ferewrwer", buttonHero: "feewrwerr"),
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
  final String heroName;
  final String buttonHero;

  const ProductListItem({Key key, @required this.heroName, this.buttonHero})
      : super(key: key);
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
                tag: heroName,
                child: CachedNetworkImage(
        imageUrl: 
                  "https://images.orgill.com/large/7615198.JPG",
                  width: 150,
                  // color: Colors.pink,
                ),
              ),
            ),
            Container(
              // color: Colors.yellow,
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "Simple Product Name",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Flexible(child:
                    Text(
                      "Simple Marketing/Packing",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15),
                    ),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Ksh.",
                            style: TextStyle(
                                color: Colors.deepPurple[200],
                                fontWeight: FontWeight.w500,
                                fontSize: 13)),
                        TextSpan(
                           text:"48.20",
                      style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w400, fontSize: 18),
                  
                      )])),
                 
                    Spacer(),
                    Hero(
                      tag: buttonHero,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

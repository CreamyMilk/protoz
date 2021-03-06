import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proto/constants.dart';
import 'package:proto/hotelCards.dart';
import 'package:proto/pages/buyerpages/getCategoriesFuture.dart';
import 'package:proto/pages/startup/cardsPage.dart';
import 'package:proto/pages/wallet/getTransactionsFuture.dart';
import 'package:proto/widgets/awesomeFab.dart';
import 'package:proto/widgets/depositBottomSheet.dart';
import 'package:proto/widgets/qrScannerButton.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class WalletsPageBase extends StatefulWidget {
  //ScrollController get n => ScrollController(initialScrollOffset: 150);
  @override
  _WalletsPageBaseState createState() => _WalletsPageBaseState();
}

class _WalletsPageBaseState extends State<WalletsPageBase> {
  @override
  void initState() {
    getLatestBalance();
    getLatestCategories();
    getLatestTransaction();
    getCurrentOrders();
    super.initState();
  }

  List<Services> sampleData = [
    Services(
        path:"/categories",
        imageUrl:
            "https://africasustainabilitymatters.com/wp-content/uploads/2020/11/Twiga_2.jpg",
        name: "Buy"),
    Services(
        path:"/sellpage",
        imageUrl:
            "https://s3.amazonaws.com/newhobbyfarms.com/2020/01/9-plows-jeff-piper-flickr-e.jpg",
        name: "Sell"),
    Services(
        path:"/walletspage",
        imageUrl:
            "https://www.michiganstateuniversityonline.com/wp-content/uploads/sites/3/2014/04/logistics-fundamentals-supply-chain.jpg",
        name: "Wallet"),
    Services(
        path:"/walletspage",
        imageUrl:
            "https://asmtech.com/wp-content/uploads/2018/03/What-we-do-_-Consultancy-1024x683.jpeg",
        name: "Finance"),
    Services(
        path:"/bl",
        imageUrl:
            "https://hingemarketing.com/wp-content/uploads/2017/08/B2B-Market-Research.png",
        name: "Consoltany"),
    Services(
        path:"/bl",
        imageUrl:
            "https://www.who.int/images/default-source/departments/health-financing/health-financing-and-uhc-(8).tmb-1200v.jpg?sfvrsn=add44264_6",
        name: "Financing"),
  ];

  @override
  Widget build(BuildContext context) {
    //TextStyle collButton = TextStyle(fontSize: 15, color: Colors.black);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: AwesomeFab(),
        body: CustomScrollView(
            //controller: n,
            slivers: [
              WalletsAppBar(),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0,
                    crossAxisCount: 2,
                    //childAspectRatio: 1,
                    crossAxisSpacing: 0),
                delegate:
                    SliverChildBuilderDelegate((BuildContext ctx, int index) {
                  if (index < 6) {
                    return HotelListTile(
                      prodname: sampleData[index].name,
                      route: sampleData[index].path,
                      imageUrl: sampleData[index].imageUrl,
                      productID: index,
                    );
                  }
                  return null;
                }),
              ),
            ]));
  }
}

class WalletsAppBar extends StatelessWidget {
  const WalletsAppBar({
    Key key,
  }) : super(key: key);
//pishori basmati milk bread50 240,250
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/profile");
          },
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black87,
            ),
            child: ValueListenableBuilder(
              valueListenable: Hive.box(Constants.UserBoxName).listenable(),
              builder: (BuildContext context, box, Widget child) {
                return Text(
                  "${box.get(Constants.InitalsStore, defaultValue: "P")}",
                );
              },
            ),
          ),
        ),
      ),
      actions: [
        QrCodeScannerIcon(),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active_outlined,
              size: 19,
              color: Colors.black26,
            )),
      ],
      expandedHeight: 172,
      floating: false,
      pinned: true,
      centerTitle: true,
      title: Text(
        "Welcome",
        style: TextStyle(color: Colors.black87),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.white]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 63,
              ),
              Text("",
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white54,
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text("Current Orders",
                          textScaleFactor: 1,
                          style:
                              TextStyle(fontSize: 10, color: Colors.black87)),
                      SizedBox(height: 3),
                      ValueListenableBuilder(
                        valueListenable:
                            Hive.box(Constants.UserBoxName).listenable(),
                        builder: (BuildContext context, box, Widget child) {
                          return Text(
                            "KSH.${box.get(Constants.OrdersStore, defaultValue: "00").toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                            textScaleFactor: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.w100),
                          );
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  FloatingActionButton(
                    elevation: 0,
                    heroTag: "sd",
                    mini: true,
                    backgroundColor: Colors.white,
                    child: Transform.rotate(
                      angle: 0,
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      depositModalBottomSheet(context, "10");
                    },
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(2.0),
                height: 40,
                decoration: BoxDecoration(color: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

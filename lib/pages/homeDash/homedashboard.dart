import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proto/constants.dart';
import 'package:proto/pages/homeDash/PhotoGridTile.dart';
import 'package:proto/pages/buyerpages/getCategoriesFuture.dart';
import 'package:proto/pages/startup/cardsPage.dart';
import 'package:proto/pages/wallet/getTransactionsFuture.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:proto/widgets/awesomeFab.dart';
import 'package:proto/widgets/depositBottomSheet.dart';
import 'package:proto/widgets/qrScannerButton.dart';
import "package:proto/utils/typeExtensions.dart";
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class DashboardPage extends StatefulWidget {
  //ScrollController get n => ScrollController(initialScrollOffset: 150);
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
        path: "/categories",
        imageUrl:
            "https://africasustainabilitymatters.com/wp-content/uploads/2020/11/Twiga_2.jpg",
        name: "Buy / Nunua"),
    Services(
        path: "/sellpage",
        imageUrl:
            "https://s3.amazonaws.com/newhobbyfarms.com/2020/01/9-plows-jeff-piper-flickr-e.jpg",
        name: "Sell / Uza Bidha"),
    Services(
        path: "/walletspage",
        imageUrl:
            "https://www.who.int/images/default-source/departments/health-financing/health-financing-and-uhc-(8).tmb-1200v.jpg?sfvrsn=add44264_6",
        name: "Wallet / Pochi"),
    Services(
        path: "/walletspage",
        imageUrl:
            "https://asmtech.com/wp-content/uploads/2018/03/What-we-do-_-Consultancy-1024x683.jpeg",
        name: "Orders / Kazi"),
    Services(
        path: "/bl",
        imageUrl:
            "https://www.michiganstateuniversityonline.com/wp-content/uploads/sites/3/2014/04/logistics-fundamentals-supply-chain.jpg",
        name: "Loan / Mkopo"),
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
              DashboardSliverAppBar(),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0,
                    crossAxisCount: 2,
                    //childAspectRatio: 1,
                    crossAxisSpacing: 0),
                delegate:
                    SliverChildBuilderDelegate((BuildContext ctx, int index) {
                  if (index < 5) {
                    return PhotoGridTile(
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

class DashboardSliverAppBar extends StatelessWidget {
  const DashboardSliverAppBar({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
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
      expandedHeight: 150,
      floating: false,
      pinned: true,
      title: ValueListenableBuilder(
        valueListenable: Hive.box(Constants.UserBoxName).listenable(),
        builder: (BuildContext context, box, Widget child) {
          String userName =
              "${box.get(Constants.FullnameStore, defaultValue: "")}";
          return now.hour < 12
              ? Text(
                  "Good Morning,\n$userName",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : now.hour < 20
                  ? Text(
                      "Good Afternoon,\n$userName ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Text("Good Evening,\n$userName",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ));
        },
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
          child: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const YMargin(70),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Current Orders",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black87)),
                          SizedBox(height: 3),
                          ValueListenableBuilder(
                            valueListenable:
                                Hive.box(Constants.UserBoxName).listenable(),
                            builder: (BuildContext context, box, Widget child) {
                              return Text(
                                "Ksh.${box.get(Constants.OrdersStore, defaultValue: "00").toString().addCommas}.00",
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
                        heroTag: "sd",
                        mini: true,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.add, color: Colors.green),
                        onPressed: () {
                          depositModalBottomSheet(context, "10");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

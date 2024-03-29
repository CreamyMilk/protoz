import 'package:flutter/material.dart';
import 'package:proto/constants.dart';
import 'package:proto/pages/buyerpages/get_categories_future.dart';
import 'package:proto/pages/homeDash/photo_grid_tile.dart';
import 'package:proto/pages/ordersPage/fetch_orders_future.dart';
import 'package:proto/pages/startup/cards_page.dart';
import 'package:proto/pages/wallet/get_transactions_future.dart';
import 'package:proto/utils/sized_margins.dart';
import 'package:proto/utils/type_extensions.dart';
import 'package:proto/widgets/add_money_bottom_sheet.dart';
import 'package:proto/widgets/awesome_fab.dart';
import 'package:proto/widgets/qr_scanner_button.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

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
            "https://res.cloudinary.com/agrocr/image/upload/v1633494084/Twiga_2_g0f7uw.jpg",
        name: "Buy / Nunua"),
    Services(
        path: "/sellpage",
        imageUrl:
            "https://res.cloudinary.com/agrocr/image/upload/v1633494134/9-plows-jeff-piper-flickr-e_p7xef7.jpg",
        name: "Sell / Uza Bidha"),
    Services(
        path: "/walletspage",
        imageUrl:
            "https://res.cloudinary.com/agrocr/image/upload/v1633494175/health-financing-and-uhc-_8_.tmb-1200v_h2ige2.jpg",
        name: "Wallet / Pochi"),
    Services(
        path: "/orders",
        imageUrl:
            "https://res.cloudinary.com/agrocr/image/upload/v1633494233/What-we-do-_-Consultancy-1024x683_s2drap.jpg",
        name: "Orders / Kazi"),
    Services(
        path: "/bl",
        imageUrl:
            "https://res.cloudinary.com/agrocr/image/upload/v1633494282/logistics-fundamentals-supply-chain_rarqvj.jpg",
        name: "Profile / Help"),
  ];

  @override
  Widget build(BuildContext context) {
    //TextStyle collButton = TextStyle(fontSize: 15, color: Colors.black);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: const AwesomeFab(),
      body: CustomScrollView(
        //controller: n,
        slivers: [
          const DashboardSliverAppBar(),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 0,
                crossAxisCount: 2,
                //childAspectRatio: 1,
                crossAxisSpacing: 0),
            delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
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
        ],
      ),
    );
  }
}

class DashboardSliverAppBar extends StatelessWidget {
  const DashboardSliverAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SliverAppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          const QrCodeScannerIcon(),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_active_outlined,
                size: 19,
                color: Colors.black,
              )),
        ],
        expandedHeight: 160,
        floating: false,
        pinned: true,
        title: ValueListenableBuilder(
          valueListenable: Hive.box(Constants.UserBoxName).listenable(),
          builder: (BuildContext context, Box<dynamic> box, Widget? child) {
            String userName =
                "${box.get(Constants.FullnameStore, defaultValue: "")}";
            return now.hour < 12
                ? Text(
                    "Good Morning,\n$userName",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : now.hour < 20
                    ? Text(
                        "Good Afternoon,\n$userName ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text("Good Evening,\n$userName",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ));
          },
        ),
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: false,
          background: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.white]),
            ),
            child: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const YMargin(110),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("/orders");
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: Hive.box(Constants.UserBoxName)
                                    .listenable(),
                                builder: (BuildContext context,
                                    Box<dynamic> box, Widget? child) {
                                  return RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                            text: "Unfulfiled Orders\n",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w200,
                                                color: Colors.blueGrey)),
                                        TextSpan(
                                          text:
                                              "(${(box.get(Constants.OrdersListStore, defaultValue: []) as List).length}) Orders\n",
                                          style: const TextStyle(
                                              color: Colors.blueGrey,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 17),
                                        ),
                                        TextSpan(
                                          text:
                                              "Total Ksh.${box.get(Constants.TotalOrdersStore, defaultValue: "00").toString().addCommas}",
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.blueGrey),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        FloatingActionButton(
                          heroTag: "sd",
                          mini: true,
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.add, color: Colors.green),
                          onPressed: () {
                            depositModalBottomSheet(context);
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
      ),
    );
  }
}

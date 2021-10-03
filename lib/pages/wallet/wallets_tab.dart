import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:proto/pages/ordersPage/fetch_orders_future.dart';
import 'package:proto/utils/type_extensions.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proto/constants.dart';
import 'package:proto/pages/wallet/get_transactions_future.dart';
import 'package:proto/utils/sized_margins.dart';
import 'package:proto/widgets/qr_scanner_button.dart';

class WalletsTab extends StatefulWidget {
  const WalletsTab({Key? key}) : super(key: key);

  @override
  _WalletsTabState createState() => _WalletsTabState();
}

class _WalletsTabState extends State<WalletsTab> {
  @override
  void initState() {
    getLatestBalance();
    getCurrentOrders();
    getLatestTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const WalletsAppBar(),
          ValueListenableBuilder(
            valueListenable: Hive.box(Constants.UserBoxName).listenable(),
            builder: (BuildContext context, Box<dynamic> box, Widget? child) {
              List<dynamic> trans =
                  box.get(Constants.TransactionsStore, defaultValue: []);
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext ctx, int index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Transactions",
                          style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                      );
                    }

                    index -= 1;
                    if (index < trans.length) {
                      var transaction = trans[index];
                      //   print(transaction);
                      bool toMe = (transaction["to"] ==
                          box.get(Constants.WalletNameStore));
                      bool isPurchase = (transaction["typename"] == "PURCHASE");
                      // bool isDeposit = (transaction["typename"] == "DEPOSIT");
                      return ListTile(
                        dense: true,
                        onTap: () {
                          isPurchase
                              ? showQRDialog(
                                  context, transaction["transactionid"])
                              : null;
                        },
                        leading: CircleAvatar(
                          child: Icon(
                            isPurchase
                                ? Icons.shopping_bag_outlined
                                : Icons.money,
                            size: 17,
                            color: isPurchase ? Colors.orange : Colors.orange,
                          ),
                          minRadius: 18,
                          maxRadius: 18,
                          backgroundColor: isPurchase
                              ? Colors.orange[50]
                              : Colors.orange[50],
                        ),
                        // heros: index,

                        title: Text(
                            "${toMe ? transaction["from"] : transaction["typename"]}"),
                        subtitle: Text("${transaction["trackid"]}"),
                        trailing: RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "${toMe ? "+" : "-"} Ksh.\n",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 10.0)),
                              TextSpan(
                                text:
                                    "${transaction["amount"].toString().addCommas} ",
                                style: TextStyle(
                                    color: isPurchase
                                        ? Colors.blueGrey
                                        : toMe
                                            ? Colors.greenAccent[400]
                                            : Colors.blueGrey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                        // imageUrl: sampleData[index].imageUrl,
                        // productID: index,
                      );
                    }
                    return null;
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class WalletsAppBar extends StatelessWidget {
  const WalletsAppBar({
    Key? key,
  }) : super(key: key);
//pishori basmati milk bread50 240,250
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Center(
        child: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
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
      expandedHeight: 220,
      floating: false,
      pinned: true,
      centerTitle: true,
      title: const Text(
        "Your Wallet",
        style: TextStyle(color: Colors.black87),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Colors.tealAccent[400]!, Colors.tealAccent[400]!]),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 30.0, left: 14.0, bottom: 8.0),
            child: Column(
              children: [
                const YMargin(90),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Total Balance",
                            textScaleFactor: 1,
                            style:
                                TextStyle(fontSize: 15, color: Colors.black87)),
                        const YMargin(3),
                        SizedBox(
                          width: screenWidth(context, percent: 0.9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ValueListenableBuilder(
                                  valueListenable:
                                      Hive.box(Constants.UserBoxName)
                                          .listenable(),
                                  builder: (BuildContext context,
                                      Box<dynamic> box, Widget? child) {
                                    return Text(
                                      box
                                          .get(Constants.BalanceStore,
                                              defaultValue: "00")
                                          .toString()
                                          .addCommas,
                                      textScaleFactor: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500),
                                    );
                                  }),
                              FloatingActionButton(
                                mini: true,
                                heroTag: "tabFab",
                                backgroundColor: Colors.black,
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed("/contactList");
                                },
                                child: const Icon(
                                  Icons.swap_calls,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const YMargin(10),
                        ValueListenableBuilder(
                            valueListenable:
                                Hive.box(Constants.UserBoxName).listenable(),
                            builder: (BuildContext context, Box<dynamic> box,
                                Widget? child) {
                              return Text(
                                "Account :${box.get(Constants.PhoneNumberStore, defaultValue: "00").toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')}",
                                textScaleFactor: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w100),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showQRDialog(BuildContext context, String token) => showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          actions: [
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("CLOSE", style: TextStyle(color: Colors.red)))
          ],
          elevation: 4,
          title: SizedBox(
            width: screenWidth(context, percent: 0.2),
            height: screenHeight(context, percent: 0.37),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "🤌Sellers should  🤳 Snan this\nto receive thier Payments",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: Colors.grey[500],
                    fontSize: 18,
                  ),
                ),
                const YMargin(20),
                QrImage(
                  data: token,
                  padding: EdgeInsets.zero,
                  version: 5,
                  foregroundColor: Colors.orange,
                  size: 180.0,
                ),
                const YMargin(12),
                Text(token),
              ],
            ),
          ),
        ),
      );
    });

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proto/constants.dart';
import 'package:proto/pages/wallet/getTransactionsFuture.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:proto/widgets/qrScannerButton.dart';

class WalletsTab extends StatefulWidget {
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

  String convertTo07(String f) {
    String no;
    String pl;
    String t5;
    no = f.replaceAll(new RegExp(r"\s+"), "");
    pl = no.replaceAll(new RegExp(r"\+"), "");
    t5 = pl.replaceAll(new RegExp(r"2547"), "07");
    return t5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          WalletsAppBar(),
          ValueListenableBuilder(
            valueListenable: Hive.box(Constants.UserBoxName).listenable(),
            builder: (BuildContext context, box, Widget child) {
              List<dynamic> trans = box.get(Constants.TransactionsStore);
              return SliverList(
                delegate:
                    SliverChildBuilderDelegate((BuildContext ctx, int index) {
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
                        box.get(Constants.PhoneNumberStore));
                    bool isPurchase = (transaction["typeid"] == 3);
                    return ListTile(
                      dense: true,
                      onTap: () {
                        isPurchase
                            ? showQRDialog(
                                context, transaction["transactionid"])
                            : print("This is something else");
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
                        backgroundColor:
                            isPurchase ? Colors.orange[50] : Colors.orange[50],
                      ),
                      // heros: index,

                      title: Text(
                          "${toMe ? transaction["from"] : transaction["fromName"]}"),
                      subtitle: Text("${transaction["transactionid"]}"),
                      trailing: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "${toMe ? "+" : "-"} Ksh.\n",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10.0)),
                            TextSpan(
                                text:
                                    "${transaction["amount"].toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                                style: TextStyle(
                                    color: isPurchase
                                        ? Colors.blueGrey
                                        : toMe
                                            ? Colors.greenAccent[400]
                                            : Colors.blueGrey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18.0)),
                          ],
                        ),
                      ),
                      // imageUrl: sampleData[index].imageUrl,
                      // productID: index,
                    );
                  }
                  return null;
                }),
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
              color: Colors.black26,
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
      expandedHeight: 200,
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
                colors: [Colors.tealAccent[400], Colors.tealAccent[400]]),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 14.0, bottom: 8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Balance",
                            textScaleFactor: 1,
                            style:
                                TextStyle(fontSize: 15, color: Colors.black87)),
                        SizedBox(height: 3),
                        Container(
                          width: screenWidth(context, percent: 0.9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ValueListenableBuilder(
                                  valueListenable:
                                      Hive.box(Constants.UserBoxName)
                                          .listenable(),
                                  builder: (BuildContext context, box,
                                      Widget child) {
                                    return Text(
                                      "${box.get(Constants.BalanceStore, defaultValue: "00").toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                                      textScaleFactor: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500),
                                    );
                                  }),
                              FloatingActionButton(
                                mini: true,
                                heroTag: null,
                                backgroundColor: Colors.black,
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed("/contactList");
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.swap_calls,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const YMargin(10),
                        ValueListenableBuilder(
                            valueListenable:
                                Hive.box(Constants.UserBoxName).listenable(),
                            builder: (BuildContext context, box, Widget child) {
                              return Text(
                                "Account :${box.get(Constants.WalletNameStore, defaultValue: "00").toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')}",
                                textScaleFactor: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
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
                child: Text("CLOSE", style: TextStyle(color: Colors.red)))
          ],
          elevation: 0,
          title: Container(
            width: screenWidth(context, percent: 0.6),
            height: screenHeight(context, percent: 0.43),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "🤌Sellers should Scan 🤳 \n to receive Funds Payment",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: Colors.grey[500],
                    fontSize: 20,
                  ),
                ),
                const YMargin(40),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proto/constants.dart' as Constants;
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
              dynamic trans = box.get(Constants.TransactionsStore);

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
                  if (index < trans.length) {
                    bool fromMe = (trans[index - 1]["to"] ==
                        box.get(Constants.PhoneNumberStore));
                    return ListTile(
                      dense: true,
                      onTap: () {},
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.money,
                          size: 17,
                          color: Colors.orange,
                        ),
                        minRadius: 18,
                        maxRadius: 18,
                        backgroundColor: Colors.orange[50],
                      ),
                      // heros: index,

                      title: Text("${trans[index - 1]["from"]}"),
                      subtitle: Text("${trans[index - 1]["transactionid"]}"),
                      trailing: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "+Ksh.\n",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10.0)),
                            TextSpan(
                                text:
                                    "${trans[index - 1]["amount"].toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                                style: TextStyle(
                                    color: fromMe
                                        ? Colors.greenAccent[400]
                                        : Colors.blueGrey,
                                    fontWeight: FontWeight.w400,
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
            child: Text("JK"),
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
                        Text(
                          "Account: 3434 5634 321",
                          textScaleFactor: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black87,
                              fontWeight: FontWeight.w100),
                        ),
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

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proto/models/past_purchase.dart';
import 'package:proto/pages/past_purchases/future_get_purchase.dart';
import 'package:proto/pages/past_purchases/past_purchases_search.dart';
import 'package:proto/utils/sized_margins.dart';
import 'package:proto/utils/type_extensions.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PastPurchasePage extends StatelessWidget {
  const PastPurchasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Past Purchases"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                  context: context, delegate: PastPurchasesSearchDelegate());
            },
          )
        ],
      ),
      body: FutureBuilder<PastPurchasesResponse?>(
        future: getPastPurchases(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            PastPurchasesResponse myPurchases = snapshot.data!;
            return Center(
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: myPurchases.purchases.length,
                  itemBuilder: (BuildContext ctx, int idx) {
                    return PurchasesTile(p: myPurchases.purchases[idx]);
                  }),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PurchasesTile extends StatelessWidget {
  const PurchasesTile({Key? key, required this.p}) : super(key: key);
  final Purchases p;
  @override
  Widget build(BuildContext context) {
    DateTime deadlineTime =
        DateTime.fromMillisecondsSinceEpoch(p.Deadline * 1000);
    String dateStr = DateFormat('MMM-d-y  hh:mm a').format(deadlineTime);
    return ListTile(
        title: Text(p.pname),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Quantity ${p.Quantity}\nDue [$dateStr] "),
          const YMargin(10),
          Chip(
              label: Text(
                p.Status,
                style: const TextStyle(color: Colors.orange),
              ),
              backgroundColor: Colors.orange[50]),
        ]),
        trailing: RichText(
          textAlign: TextAlign.end,
          text: TextSpan(
            children: [
              const TextSpan(
                  text: "Ksh.\n",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 10.0)),
              TextSpan(
                text: p.total.toString().addCommas,
                style: TextStyle(
                    color: Colors.greenAccent[400],
                    fontWeight: FontWeight.w300,
                    fontSize: 18.0),
              ),
            ],
          ),
        ),
        onTap: () {
          showOrderQrDialog(context, p.code);
        });
  }
}

showOrderQrDialog(BuildContext context, String token) => showCupertinoDialog(
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
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "🤌Sellers should  🤳 Scan this\nto receive thier Payment",
                  textAlign: TextAlign.center,
                  style: TextStyle(
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

import 'package:flutter/material.dart';

class PastPurchasePage extends StatelessWidget {
  const PastPurchasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Past Purchases"),
      ),
      body: FutureBuilder<List<PPurchase>>(
        future: getPastPurchases(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<PPurchase> myPurchases = snapshot.data!;
            return Center(
              child: ListView.builder(itemBuilder: (BuildContext ctx, int idx) {
                return PastPurchaseTile(purchase: myPurchases[idx]);
              }),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class PPurchase {
  PPurchase(this.settlementCode, this.status, this.orderID, this.productID,
      this.productName, this.totalAmount, this.timeDue);
  final String settlementCode;
  final String status;
  final String orderID;
  final String productID;
  final String productName;
  final String totalAmount;
  final String timeDue;
}

class PastPurchaseTile extends StatelessWidget {
  const PastPurchaseTile({Key? key, required this.purchase}) : super(key: key);
  final PPurchase purchase;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<List<PPurchase>> getPastPurchases() async {
  List<PPurchase> myPurchases = [];
  Future.delayed(
    const Duration(seconds: 12),
  );
  return myPurchases;
}

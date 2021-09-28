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
              child: ListView.builder(
                  itemCount: myPurchases.length,
                  itemBuilder: (BuildContext ctx, int idx) {
                    return PastPurchaseTile(purchase: myPurchases[idx]);
                  }),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PPurchase {
  PPurchase(
      {required this.settlementCode,
      required this.status,
      required this.orderID,
      required this.productID,
      required this.productName,
      required this.productQuantity,
      required this.totalAmount,
      required this.timeDue});
  final String settlementCode;
  final String status;
  final String orderID;
  final String productID;
  final String productName;
  final String productQuantity;
  final String totalAmount;
  final String timeDue;
}

class PastPurchaseTile extends StatelessWidget {
  const PastPurchaseTile({Key? key, required this.purchase}) : super(key: key);
  final PPurchase purchase;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(purchase.productName),
      subtitle: Text("Quantity :${purchase.productQuantity}"),
    );
  }
}

Future<List<PPurchase>> getPastPurchases() async {
  List<PPurchase> myPurchases = [
    PPurchase(
        settlementCode: "12",
        status: "12",
        orderID: "orderI1212D",
        productID: "",
        productName: "Sample Purchase",
        totalAmount: "",
        timeDue: "",
        productQuantity: '22')
  ];
  await Future.delayed(const Duration(seconds: 2));
  return myPurchases;
}

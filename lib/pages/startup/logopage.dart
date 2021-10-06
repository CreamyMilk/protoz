import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proto/constants.dart';
import 'package:proto/main.dart';
import 'package:proto/pages/buyerpages/get_categories_future.dart';
import 'package:proto/pages/ordersPage/fetch_orders_future.dart';
import 'package:proto/pages/wallet/get_transactions_future.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({Key? key}) : super(key: key);

  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  Box<dynamic> hiveBox = Hive.box(Constants.UserBoxName);
  @override
  void initState() {
    super.initState();
    getLatestCategories();
    if (Platform.isAndroid) {
      FirebaseMessaging.onMessage.listen((event) {
        if (event.data["type"] == "registration") {
          Navigator.of(navigatorKey.currentContext!).pushNamed("/login");
        } else if (event.data["type"] == "deposit") {
          showCupertinoDialog(
              context: navigatorKey.currentContext!,
              builder: (context) => AlertDialog(
                  title: const Text("Deposit Successfuly"),
                  content: Text("Ksh${event.data["amount"]}")));
        } else if (event.data["type"] == "orderplace") {
          showCupertinoDialog(
              context: navigatorKey.currentContext!,
              builder: (context) => AlertDialog(
                  title: Text("Order Placed for ${event.data["prodname"]}"),
                  content: Text(
                      "Ksh${event.data["amount"]}\n Quantity :${event.data["quantity"]}")));
        } else if (event.data["type"] == "ordercomplete") {
          showCupertinoDialog(
              context: navigatorKey.currentContext!,
              builder: (context) => const AlertDialog(
                  title: Text("Order Complete"),
                  content: Text("seller has been payed for the product")));
        } else if (event.data["type"] == "sellerwin") {
          showCupertinoDialog(
              context: navigatorKey.currentContext!,
              builder: (context) => const AlertDialog(
                  title: Text("Invoice Settled Succesfully"),
                  content: Text("Funds have been depoisted to your wallet")));
        }

        getLatestBalance();
        getCurrentOrders();
        getLatestTransaction();
      });

      FirebaseMessaging.instance.getToken().then((String? token) {
        hiveBox.put(Constants.RawFCMTokenStore, token!);
      });

      FirebaseMessaging.instance.subscribeToTopic(
          hiveBox.get(Constants.NotifcationTopicStore, defaultValue: "."));
      FirebaseMessaging.instance.subscribeToTopic(
          hiveBox.get(Constants.AllUserNotifcationTopic, defaultValue: "all"));
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
        //When the user Clicked the notifcation and the app was completly closed
        getLatestBalance();
        getCurrentOrders();
        getLatestTransaction();
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        getLatestBalance();
        getCurrentOrders();
        getLatestTransaction();
      });
      // FirebaseMessaging.onBackgroundMessage((message) => {});
    }
  }

  void autoNavigate(BuildContext context) {
    bool isLoggedIn =
        hiveBox.get(Constants.IsLoggedInStore, defaultValue: false);
    //Handle Token Confirmation here
    Future.delayed(const Duration(seconds: 3), () {
      !isLoggedIn
          ? Navigator.of(context).pushReplacementNamed("/startup")
          : Navigator.of(context).pushReplacementNamed("/dashboard");
    });
  }

  @override
  Widget build(BuildContext context) {
    autoNavigate(context);
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Hero(
            tag: "logo",
            child: Image(
              image: AssetImage('assets/images/agric.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proto/constants.dart';
import 'package:proto/main.dart';
import 'package:proto/pages/buyerpages/getCategoriesFuture.dart';
import 'package:proto/pages/wallet/getTransactionsFuture.dart';

class LogoPage extends StatefulWidget {
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
        if (event.data["type"] == "role") {
          String role = event.data["content"].trim();
          switch (role) {
            case "Farmer":
              Navigator.of(navigatorKey.currentContext)
                  .pushNamed("/addProduct");
              break;
            default:
              Navigator.of(navigatorKey.currentContext).pushNamed("/login");
              break;
          }
        } else if(event.data["type"] == "received") {
             showCupertinoDialog(
              context: navigatorKey.currentContext,
              builder: (context) =>
                  AlertDialog(title: Text("Funds Received"), content: Text("Ksh${event.data["amount"]}")));
        }
        else if(event.data["type"] == "deposit") {
             showCupertinoDialog(
              context: navigatorKey.currentContext,
              builder: (context) =>
                  AlertDialog(title: Text("Deposit Successfuly"), content: Text("Ksh${event.data["amount"]}")));
        }
        else if(event.data["type"] == "order") {
             showCupertinoDialog(
              context: navigatorKey.currentContext,
              builder: (context) =>
                  AlertDialog(title: Text("Order Placed for ${event.data["prodname"]}"), content: Text("Ksh${event.data["amount"]}\n Quantity :${event.data["quantity"]}")));
        }
        else {
          showCupertinoDialog(
              context: navigatorKey.currentContext,
              builder: (context) =>
                  AlertDialog(title: Text("Incomming Notification"), content: Text(" ${event.data}")));
        }
        //Opened Nofication when app is active
        getLatestBalance();
        getCurrentOrders();
        getLatestTransaction();
      });
      FirebaseMessaging.instance.getToken().then((String token) {
        hiveBox.get(Constants.RawFCMTokenStore, defaultValue: "all");
      });

      FirebaseMessaging.instance.subscribeToTopic(
          hiveBox.get(Constants.NotifcationTopicStore, defaultValue: "."));
      FirebaseMessaging.instance.subscribeToTopic(
          hiveBox.get(Constants.AllUserNotifcationTopic, defaultValue: "all"));
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage message) {
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
    Future.delayed(Duration(seconds: 3), () {
      !isLoggedIn
          ? Navigator.of(context).pushReplacementNamed("/startup")
          : Navigator.of(context).pushReplacementNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    autoNavigate(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: "logo",
            child: Icon(
              Icons.toll_outlined,
              size: 100,
            ),
          ),
        ),
      ),
    );
  }
}

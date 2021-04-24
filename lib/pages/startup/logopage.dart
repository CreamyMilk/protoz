import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import "package:proto/constants.dart" as Constants;
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
    if (Platform.isAndroid) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        //Opened Nofication when app is active
        getLatestBalance();
        getLatestTransaction();
        showCupertinoDialog(
            context: context,
            builder: (context) =>
                AlertDialog(title: Text("ok"), content: Text("Updateo")));
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
        getLatestTransaction();
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        getLatestBalance();
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

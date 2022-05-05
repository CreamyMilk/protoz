import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proto/constants.dart';
import 'package:proto/main.dart';
import "package:qr_flutter/qr_flutter.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.local_airport_sharp,
                  color: Colors.black,
                ),
                onPressed: () {
                  logoutHandler();
                })
          ],
          title:
              const Text("Profile Page", style: TextStyle(color: Colors.black)),
        ),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "👋 Payment QR Code ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ValueListenableBuilder(
                    valueListenable:
                        Hive.box(Constants.UserBoxName).listenable(),
                    builder: (BuildContext context, Box<dynamic> box, widget) {
                      return QrImage(
                        data:
                            "SM|${box.get(Constants.PhoneNumberStore, defaultValue: "")}",
                        padding: const EdgeInsets.all(8.0),
                        version: QrVersions.auto,
                        foregroundColor: Colors.black,
                        size: 180.0,
                      );
                    }),
                const SizedBox(height: 50),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.black38,
                  child: const Text("Create Custom Invoice",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ],
            )));
  }
}

logoutHandler() {
  Box<dynamic> box = Hive.box(Constants.UserBoxName);
  if (Platform.isAndroid) {
    FirebaseMessaging.instance
        .unsubscribeFromTopic(
            box.get(Constants.NotifcationTopicStore, defaultValue: "."))
        .then((value) => {box.clear()});

    FirebaseMessaging.instance
        .unsubscribeFromTopic(
            box.get(Constants.WalletNameStore, defaultValue: "."))
        .then((value) => {box.clear()});
  }
  box.put(Constants.IsLoggedInStore, false);
  box.put(Constants.TransactionsStore, []);
  box.put(Constants.BalanceStore, 0);
  box.put(Constants.TotalOrdersStore, 0);
  box.clear();
  Navigator.pushNamedAndRemoveUntil(
      navigatorKey.currentContext!, "/startup", (predicatestuff) => false);
}

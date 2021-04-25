import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import "package:proto/constants.dart" as Constants;
import "package:qr_flutter/qr_flutter.dart";

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.local_airport_sharp,
                  color: Colors.black,
                ),
                onPressed: () {
                  logout(context);
                })
          ],
          title: Text("Profile Page", style: TextStyle(color: Colors.black)),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text(
                  "👋 Payment QR Code ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ValueListenableBuilder(
                    valueListenable:
                        Hive.box(Constants.UserBoxName).listenable(),
                    builder: (context, box, widget) {
                      return QrImage(
                        data:
                            "SM|${box.get(Constants.PhoneNumberStore, defaultValue: "")}",
                        padding: EdgeInsets.all(8.0),
                        version: QrVersions.auto,
                        foregroundColor: Colors.black,
                        size: 180.0,
                      );
                    }),
                SizedBox(height: 50),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.black38,
                  child: Text("Create Custom Invoice",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                SizedBox(height: 100),
              ],
            )));
  }

  void logout(BuildContext ctx) {
    Box<dynamic> box = Hive.box(Constants.UserBoxName);
    box.put(Constants.IsLoggedInStore, false);
    if (Platform.isAndroid) {
      FirebaseMessaging.instance.unsubscribeFromTopic(
          box.get(Constants.NotifcationTopicStore, defaultValue: "."));
    }

    Navigator.of(ctx).pushReplacementNamed("/startup");
  }
}

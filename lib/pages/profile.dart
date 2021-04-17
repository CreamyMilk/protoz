import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import "package:proto/constants.dart" as Constants;

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        elevation: 0,
        title: Text("Profile Page"),
      ),
    );
  }

  void logout(BuildContext ctx) {
    Box<dynamic> box = Hive.box(Constants.UserBoxName);
    box.put(Constants.IsLoggedInStore, false);
    Navigator.of(ctx).pushReplacementNamed("/startup");
  }
}

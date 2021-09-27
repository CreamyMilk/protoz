import 'package:flutter/material.dart';
import 'package:proto/pages/blPages/profile.dart';
import 'package:proto/utils/sizedMargins.dart';

class BLPage extends StatelessWidget {
  const BLPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const Divider(),
          ListTile(
            title: const Text(
              "My Purchases",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/pastpurchases");
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              "Personal Details",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/profile");
            },
          ),
          const Divider(),
          ListTile(
              title: const Text(
                "Training Videos",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 20,
              ),
              onTap: () {}),
          const Divider(),
          ListTile(
            title: const Text(
              "Consoltants",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/blconsoltants");
            },
          ),
          const YMargin(10),
          OutlinedButton(
            onPressed: () {
              logoutHandler();
            },
            child: Row(children: const [
              Text(
                "Log Out",
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
              Icon(Icons.login_rounded, color: Colors.black),
            ]),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BLPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
        elevation: 0,
        centerTitle: true,
        title: Text(
          "BD page",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Divider(),
          ListTile(
              dense: true,
              title: Text(
                "FAQ",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                size: 20,
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/youtube");
              }),
          Divider(),
          ListTile(
              title: Text(
                "Training Videos",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                size: 20,
              ),
              onTap: () {
                print("Oya");
              }),
          Divider(),
          ListTile(
              title: Text(
                "Consoltants",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                size: 20,
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/blconsoltants");
              }),
          Divider(),
          ListTile(
              title: Text(
                "Profile",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                size: 20,
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/profile");
              }),
        ],
      ),
    );
  }
}

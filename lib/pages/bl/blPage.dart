import 'package:flutter/material.dart';

class BLPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
        title: Text("BD Page"),
      ),
      body: Column(
        children: [
          ListTile(
              title: Text(
                "FAQ",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).pushNamed("/youtube");
              }),
          Divider(),
          ListTile(
              title: Text(
                "Training Videos",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                print("Oya");
              }),
          Divider(),
          ListTile(
              title: Text(
                "Consoltants",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).pushNamed("/blconsoltants");
              }),
          Divider(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BlVets extends StatelessWidget {
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
                "Cattle",
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: Icon(Icons.mode_comment_outlined),
              onTap: () {
                Navigator.of(context).pushNamed("/vetsCalls");
              }),
          Divider(),
          ListTile(
              title: Text(
                "Horses",
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: Icon(Icons.mode_comment_outlined),
              onTap: () {
                Navigator.of(context).pushNamed("/vetsCalls");
                print("Oya");
              }),
          Divider(),
          ListTile(
              title: Text(
                "Dogs",
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: Icon(Icons.mode_comment_outlined),
              onTap: () {
                Navigator.of(context).pushNamed("/vetsCalls");
              }),
          Divider(),
        ],
      ),
    );
  }
}

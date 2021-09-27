import 'package:flutter/material.dart';

class BlVets extends StatelessWidget {
  const BlVets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
        title: const Text("BD Page"),
      ),
      body: Column(
        children: [
          ListTile(
              title: const Text(
                "Cattle",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: const Icon(Icons.mode_comment_outlined),
              onTap: () {
                Navigator.of(context).pushNamed("/vetsCalls");
              }),
          const Divider(),
          ListTile(
              title: const Text(
                "Horses",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: const Icon(Icons.mode_comment_outlined),
              onTap: () {
                Navigator.of(context).pushNamed("/vetsCalls");
              }),
          const Divider(),
          ListTile(
              title: const Text(
                "Dogs",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: const Icon(Icons.mode_comment_outlined),
              onTap: () {
                Navigator.of(context).pushNamed("/vetsCalls");
              }),
          const Divider(),
        ],
      ),
    );
  }
}

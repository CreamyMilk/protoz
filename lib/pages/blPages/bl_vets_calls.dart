import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BlVetsCall extends StatelessWidget {
  const BlVetsCall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vets"),
      ),
      body:
          Column(children: const [ContactTile(), ContactTile(), ContactTile()]),
    );
  }
}

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        const url = 'tel:+2548889898';
        if (await canLaunch(url)) {
          await launch(url);
        }
        // print("Fix url");
      },
      title: const Text("Name"),
      subtitle: const Text("Location"),
      trailing: const Icon(Icons.phone),
    );
  }
}

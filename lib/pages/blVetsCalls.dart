import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BlVetsCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vets"),
      ),
      body: Column(children: [ContactTile(), ContactTile(), ContactTile()]),
    );
  }
}

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        const url = 'tel:+2548889898';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          print("Fix url");
        }
      },
      title: Text("Name"),
      subtitle: Text("Location"),
      trailing: Icon(Icons.phone),
    );
  }
}

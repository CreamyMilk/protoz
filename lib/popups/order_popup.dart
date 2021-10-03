import 'package:flutter/material.dart';

class ParseOrdersPopup extends StatelessWidget {
  const ParseOrdersPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Handle Order'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Scan user provided QR to complete the order"),
        ],
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Exit'),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/qrscanner");
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Scan Now'),
        ),
      ],
    );
  }
}

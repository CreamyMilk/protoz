import 'package:flutter/material.dart';

class SuccesfulSentMoneyPopUp extends StatelessWidget {
  const SuccesfulSentMoneyPopUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sent successful'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Transaction was successful"),
        ],
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/dashboard");
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Go Home'),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/contactList'));
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Exit'),
        ),
      ],
    );
  }
}

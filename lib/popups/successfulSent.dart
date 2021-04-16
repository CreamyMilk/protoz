import 'package:flutter/material.dart';

class SuccesfulSentMoneyPopUp extends StatelessWidget {
  const SuccesfulSentMoneyPopUp ({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text('Sent successful'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Transaction was successful"),
          
        ],
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/home");
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Go Home'),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Exit'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class UnregisteredPopUp extends StatelessWidget {
  const UnregisteredPopUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('User does not have a wallet'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("User is not registerd in the AgroCRM app"),
        ],
      ),
      actions: <Widget>[
        // MaterialButton(
        //   onPressed: () {
        //     Navigator.of(context).pushNamed("/home");
        //   },
        //   textColor: Theme.of(context).primaryColor,
        //   child: const Text('Payment Complete'),
        // ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}

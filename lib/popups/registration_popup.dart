import 'package:flutter/material.dart';

class RegistrationPopUp extends StatelessWidget {
  const RegistrationPopUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Request Sent Sucessfully'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Kindly Enter your PIN to authorize Payment"),
        ],
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/login");
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Payment Complete'),
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

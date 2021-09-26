import 'package:flutter/material.dart';

class ErrorPopUP extends StatelessWidget {
  const ErrorPopUP({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Network Error'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Kindly Connect to a stable network connection"),
          Text("and try again later")
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

class CannotLoginPopUp extends StatelessWidget {
  final String message;

  const CannotLoginPopUp({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Login Error Account'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("Kindly confirm the enterd details and try again"),
          Text(message)
        ],
      ),
      actions: <Widget>[
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

class CustomErrorPopup extends StatelessWidget {
  final String message;

  const CustomErrorPopup({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Custom Error'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Text(message)],
      ),
      actions: <Widget>[
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

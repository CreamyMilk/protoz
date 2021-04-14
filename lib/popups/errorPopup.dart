import 'package:flutter/material.dart';

class ErrorPopUP extends StatelessWidget {
  const ErrorPopUP ({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text('Network Error'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Kindly Connect to a stable network connection"),
          
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

class CannontReigsterPopUp extends StatelessWidget {
  final String message;

  const CannontReigsterPopUp({Key key, @required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text('Error Register Account'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Kindly confirm the form details and try again"),
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

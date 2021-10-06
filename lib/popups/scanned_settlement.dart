import 'package:flutter/material.dart';

class ScannedSuccesfullyPopup extends StatelessWidget {
  const ScannedSuccesfullyPopup({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Settled Invoice'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
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
            Navigator.of(context).pushNamed("/home");
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Go Home'),
        ),
      ],
    );
  }
}

class FailedToSettleInvoice extends StatelessWidget {
  const FailedToSettleInvoice({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Failed To Settle Invoice'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
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
            Navigator.of(context).pushNamed("/home");
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Go Home'),
        ),
      ],
    );
  }
}

class DetectedSettlementPopup extends StatelessWidget {
  const DetectedSettlementPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Invoice Detected'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Settling order please wait"),
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
            Navigator.of(context).pushNamed("/home");
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Go Home'),
        ),
      ],
    );
  }
}

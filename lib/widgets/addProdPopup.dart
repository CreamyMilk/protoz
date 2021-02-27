import 'package:flutter/material.dart';

class AppProductPopUp extends StatelessWidget {
  const AppProductPopUp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text('Added Succesfully'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Product Has been added to the public store front"),
        ],
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/home");
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Exit'),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Add Another Product'),
        ),
      ],
    );
  }
}

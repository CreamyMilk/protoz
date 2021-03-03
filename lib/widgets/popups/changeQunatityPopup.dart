import 'package:flutter/material.dart';

class ChangeQunatityPopUp extends StatelessWidget {
  const ChangeQunatityPopUp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'Stock Editor',
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Current Stock of seeds -> 900",
            style: TextStyle(fontSize: 15),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 10),
                height: 30,
                width: 60,
                child: Text(
                  "New Stock",
                ),
              ),
              Container(
                height: 30,
                width: 120,
                child: TextField(
                  cursorColor: Colors.teal,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Cancel'),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('UPDATE'),
        ),
      ],
    );
  }
}

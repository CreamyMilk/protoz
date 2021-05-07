import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
class AwesomePopup extends StatelessWidget {
  const AwesomePopup({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BackdropFilter( filter: 
        ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: 

        new CupertinoAlertDialog(
      
      title: const Text('Confirm Payment'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          ],
      ),
      actions: <Widget>[
         new MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.red,
          child: const Text('Edit'),
        ), new MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Purchase'),
        ),
      ],
      ),); } }

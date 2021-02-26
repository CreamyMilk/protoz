
import 'package:flutter/material.dart';

class AwesomePopup extends StatelessWidget {
  const AwesomePopup({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
           Dismissible(
        key: Key("sdsd"),
        onDismissed: (direction) {},
        child: Card(
            child: Container(
                height: 50,
                child: Row(children: [
                  Hero(
                    tag: 'button 1',
                    child: InkWell(
                      onTap: () {
                        print("meme");
                      },
                      child: Container(
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          width: 90,
                          height: 50,
                          color: Color(0xfffecf0a),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text("Buy Now"),
                                Spacer(),
                                Icon(Icons.assignment_turned_in),
                              ],
                            ),
                          )),
                    ),
                  ),
                ]))),
      ),
        ],
      ),
      actions: <Widget>[
        new MaterialButton(
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

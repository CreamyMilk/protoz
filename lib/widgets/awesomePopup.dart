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
          ListTile(
            leading: Icon(Icons.car_rental),
            dense: true,
            visualDensity: VisualDensity(horizontal: .001, vertical: .001),
            //tileColor: Colors.pink,
            onTap: () {},
            title: Text("Delivery Cost",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 22)),
            trailing: Switch(
              activeColor: Colors.black,
              value: true,
              onChanged: (bool value) {},
            ),
          ),
          Dismissible(
            movementDuration: const Duration(seconds: 5),
            secondaryBackground: Container(
              color: Colors.amber,
            ),
            background: Container(
              color: Colors.pink,
            ),
            key: Key("sdsd"),
            onDismissed: (direction) {},
            child: Container(
                height: 50,
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: 500,
                    height: 50,
                    color: Color(0xfffecf0a),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text("Slide To>>>>>"),
                          Spacer(),
                          Icon(Icons.pool)
                        ],
                      ),
                    ))),
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

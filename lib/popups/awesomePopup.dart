import 'package:flutter/material.dart';

class AwesomePopup extends StatelessWidget {
  const AwesomePopup({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text('Slide to confirm Payment'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         
          // ListTile(
           
          //   dense: true,
            
          //   //tileColor: Colors.pink,
          //   onTap: () {},
          //   title: Text("Delivery Cost",
          //       style: TextStyle(
          //           color: Colors.black,
          //           fontWeight: FontWeight.w500,
          //           fontSize: 15)),

          // ),
          Dismissible(
            movementDuration: const Duration(seconds: 5),
            secondaryBackground: Container(
              color: Colors.pink,
            ),
            background: Container(
              child: Icon(Icons.thumb_up_outlined),
              color: Colors.amber,
            ),
            key: Key("sdsd"),
            onDismissed: (direction) {},
            child: Container(
                height: 50,
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: 500,
                    height: 50,
                    color: Colors.lightGreenAccent,
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text("Pay 48.50 "),
                          Spacer(),
                          Icon(Icons.send_outlined)
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

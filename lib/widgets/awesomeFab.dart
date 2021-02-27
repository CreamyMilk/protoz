import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AwesomeFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      //visible: dialVisible,
      curve: Curves.easeIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.person_outline_sharp, color: Colors.white),
          backgroundColor: Colors.teal,
          onTap: () {
            Navigator.of(context).pushNamed("/sellpage");
            // storeP.switchRents();
            // settingModalBottomSheet(context, '1');
            print("STK push sent");
          },
          label: 'My Profile',
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.teal,
        ),
        SpeedDialChild(
          child: Icon(Icons.monetization_on_outlined, color: Colors.white),
          backgroundColor: Colors.lightGreen,
          onTap: () {},
          label: 'My Orders',
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.lightGreen,
        ),
        SpeedDialChild(
          child:
              Icon(Icons.account_balance_wallet_outlined, color: Colors.black),
          backgroundColor: Colors.yellowAccent,
          onTap: () {
            print("STK push sent");
          },
          label: 'My Wallet',
          labelStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.yellowAccent,
        ),
      ],
    );
  }
}

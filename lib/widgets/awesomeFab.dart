import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AwesomeFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      heroTag: "tabFab",
      buttonSize: 51,
      iconTheme: IconThemeData(size: 10),
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 20.0),
      curve: Curves.bounceInOut,
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
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.lightGreen,
        ),
        SpeedDialChild(
          foregroundColor: Colors.white,
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

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AwesomeFab extends StatelessWidget {
  const AwesomeFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      heroTag: "tabFab",
      buttonSize: 51,
      iconTheme: const IconThemeData(size: 10),
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 20.0),
      curve: Curves.bounceInOut,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.person_outline_sharp, color: Colors.white),
          backgroundColor: Colors.teal,
          onTap: () {
            Navigator.of(context).pushNamed("/sellpage");
            // storeP.switchRents();
            // settingModalBottomSheet(context, '1');
            //print("STK push sent");
          },
          label: 'My Stock',
          labelStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.teal,
        ),
        SpeedDialChild(
          child:
              const Icon(Icons.monetization_on_outlined, color: Colors.white),
          backgroundColor: Colors.lightGreen,
          onTap: () {
            Navigator.of(context).pushNamed("/orders");
          },
          label: 'My Orders',
          labelStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.lightGreen,
        ),
        SpeedDialChild(
          foregroundColor: Colors.white,
          child: const Icon(Icons.account_balance_wallet_outlined,
              color: Colors.black),
          backgroundColor: Colors.yellowAccent,
          onTap: () {
            Navigator.of(context).pushNamed("/contactList");
          },
          label: 'My Wallet',
          labelStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.yellowAccent,
        ),
      ],
    );
  }
}

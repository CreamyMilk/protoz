import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proto/pages/bl/blPage.dart';
import 'package:proto/pages/sellerpages/stockList.dart';
import 'package:proto/pages/transactionPage.dart';

import 'package:proto/pages/walletsliver.dart';

class BaseTabView extends StatefulWidget {
  @override
  _BaseTabViewState createState() => _BaseTabViewState();
}

class _BaseTabViewState extends State<BaseTabView> {
  final _tabs = [
    WalletsPageBase(),
    InventoryList(),
    TransactionClass(),
    BLPage(),
    WalletsPageBase(),
  ];
  int _activetab;
  @override
  void initState() {
    _activetab = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var text = Text("Home",
    //  style: TextStyle(color: _activetab != 0 ? Colors.grey : Colors.blue));
    var homeItem = BottomNavigationBarItem(
        // ignore: deprecated_member_use
        label: "Home",
        icon: Icon(Icons.home_outlined, color: Colors.grey[500]),
        activeIcon: Icon(Icons.home, color: Colors.teal));
    var serviceItem = BottomNavigationBarItem(
        label: "Sell",
        icon: Icon(Icons.shop_two_outlined, color: Colors.grey),
        activeIcon: Icon(
          Icons.shop_two_rounded,
          color: Colors.teal,
        ));
    var krainItem = BottomNavigationBarItem(
        label: "Wallet",
        icon: Hero(
            tag: "wallet",
            child: Icon(Icons.attach_money_rounded, color: Colors.grey)),
        activeIcon: Icon(Icons.attach_money_outlined, color: Colors.teal));
    var shopItem = BottomNavigationBarItem(
        label: "Training",
        icon: Icon(Icons.school_outlined, color: Colors.grey),
        activeIcon: Icon(Icons.school, color: Colors.teal));
    var callItem = BottomNavigationBarItem(
        label: "Profile",
        icon: Icon(Icons.contact_phone_outlined, color: Colors.grey),
        activeIcon: Icon(Icons.contact_phone, color: Colors.teal));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: 12,
              unselectedFontSize: 10,
              iconSize: 20,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.teal,
              type: BottomNavigationBarType.fixed,
              currentIndex: _activetab,
              onTap: (index) {
                if (index < _activetab) {
                  setState(() {
                    _activetab = index;
                  });
                } else {
                  setState(() {
                    _activetab = index;
                  });
                }
              },
              items: [homeItem, serviceItem, krainItem, shopItem, callItem]),
          body: SafeArea(child: _tabs[_activetab]),
        ),
      ),
    );
  }
}

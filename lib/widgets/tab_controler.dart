import 'package:flutter/material.dart';
import 'package:proto/pages/services/blPage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:proto/pages/sellerpages/stockList.dart';
import 'package:proto/pages/transactionPage.dart';

import 'package:proto/pages/walletsliver.dart';

class BaseTabView extends StatefulWidget {
  @override
  _BaseTabViewState createState() => _BaseTabViewState();
}

class _BaseTabViewState extends State<BaseTabView>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  final _tabs = [
    WalletsPageBase(),
    InventoryList(),
    TransactionClass(),
    BLPage(),
  ];
  int _activetab;
  @override
  void initState() {
    _activetab = 0;
    setState(() {
      tabController = TabController(vsync: this, length: 4, initialIndex: 0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var text = Text("Home",
    //  style: TextStyle(color: _activetab != 0 ? Colors.grey[400] : Colors.blue));
    var homeItem = SalomonBottomBarItem(
        title: Text("Home"),
        icon: Icon(Icons.home_outlined, color: Colors.grey[400]),
        activeIcon: Icon(Icons.home, color: Colors.teal));
    var serviceItem = SalomonBottomBarItem(
        title: Text("Sell"),
        icon: Icon(Icons.shop_two_outlined, color: Colors.grey[400]),
        activeIcon: Icon(
          Icons.shop_two_rounded,
          color: Colors.teal,
        ));
    var krainItem = SalomonBottomBarItem(
        title: Text("Wallet"),
        icon: Icon(Icons.attach_money_rounded, color: Colors.grey[400]),
        activeIcon: Icon(Icons.attach_money_outlined, color: Colors.teal));
    var shopItem = SalomonBottomBarItem(
        title: Text("Training"),
        icon: Icon(Icons.school_outlined, color: Colors.grey[400]),
        activeIcon: Icon(Icons.school, color: Colors.teal));
  
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: SalomonBottomBar(
            selectedItemColor: Colors.teal,
            currentIndex: _activetab,
            onTap: (index) => setState(() {
                  _activetab = index;
                  tabController.animateTo(index);
                }),
            items: [homeItem, serviceItem, krainItem, shopItem]),
        body: SafeArea(
            child: TabBarView(
                controller: tabController,
                physics: NeverScrollableScrollPhysics(),
                children: _tabs)),
      ),
    );
  }
}

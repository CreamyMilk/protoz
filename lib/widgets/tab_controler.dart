import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proto/pages/homeDash/homedashboard.dart';
import 'package:proto/pages/services/blPage.dart';
import 'package:proto/pages/wallet/walletsTab.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:proto/pages/sellerpages/stockList.dart';
import 'package:proto/pages/logisticsSeller/newMachinery.dart';
import 'package:proto/constants.dart';

class BaseTabView extends StatefulWidget {
  @override
  _BaseTabViewState createState() => _BaseTabViewState();
}

class _BaseTabViewState extends State<BaseTabView>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  final overLayColors = [
    Colors.white,
    Colors.white,
    Colors.tealAccent[400],
    Colors.white
  ];
  final _tabs = [
    DashboardPage(),
    ValueListenableBuilder(
      valueListenable: Hive.box(Constants.UserBoxName).listenable(),
      // ignore: top_level_function_literal_block
      builder: (BuildContext context, dynamic box, Widget widget) {
        bool isMachineGuy =
            box.get(Constants.RoleStore, defaultValue: "noRole") == "Machinery";
        return isMachineGuy ? InventoryList() : MachineInventory();
      },
    ),
    //
    WalletsTab(),
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
    var walletItem = SalomonBottomBarItem(
        title: Text("Wallet"),
        icon: Icon(Icons.attach_money_rounded, color: Colors.grey[400]),
        activeIcon: Icon(Icons.attach_money_outlined, color: Colors.teal));
    var shopItem = SalomonBottomBarItem(
        title: Text("Training"),
        icon: Icon(Icons.school_outlined, color: Colors.grey[400]),
        activeIcon: Icon(Icons.school, color: Colors.teal));

    return WillPopScope(
      onWillPop: () async => false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: overLayColors[_activetab], //i like transaparent :-)
          systemNavigationBarColor: Colors.white, // navigation bar color
          statusBarIconBrightness: Brightness.dark, // status bar icons' color
          systemNavigationBarIconBrightness:
              Brightness.dark, //navigation bar icons' color
        ),
        child: Scaffold(
          bottomNavigationBar: SalomonBottomBar(
              selectedItemColor: Colors.teal,
              currentIndex: _activetab,
              onTap: (index) => setState(() {
                    _activetab = index;
                    tabController.animateTo(index);
                  }),
              items: [homeItem, serviceItem, walletItem, shopItem]),
          body: SafeArea(
              child: TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: _tabs)),
        ),
      ),
    );
  }
}

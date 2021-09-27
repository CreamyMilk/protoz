import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proto/constants.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:proto/utils/type_extensions.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Orders Section"),
          bottom: TabBar(
            tabs: const [
              Tab(text: "Due"),
              Tab(text: "Completed"),
            ],
          ),
        ),
        body: TabBarView(children: [
          Column(
            children: [
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: Hive.box(Constants.UserBoxName).listenable(),
                  builder:
                      (BuildContext context, Box<dynamic> box, Widget? child) {
                    List<dynamic> orders =
                        box.get(Constants.OrdersListStore, defaultValue: []);
                    return ListView.separated(
                      itemCount: orders.length,
                      separatorBuilder: (BuildContext ctx, int idx) {
                        return Divider();
                      },
                      itemBuilder: (BuildContext ctx, int index) {
                        if (index < orders.length) {
                          var singleOrder = orders[index];
                          return ListTile(
                            onTap: () {
                              //print("hello Mr order");
                            },
                            dense: true,
                            subtitle: Text("${singleOrder["buyer"]}"),
                            title: Text("Nfts Green (${singleOrder["eid"]})"),
                            trailing: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                      text: "Ksh.\n",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10.0)),
                                  TextSpan(
                                    text:
                                        " ${singleOrder["total"].toString().addCommas}",
                                    style: TextStyle(
                                        color: Colors.green[400],
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const XMargin(1);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          const Text("Ola Comrade")
        ]),
      ),
    );
  }
}

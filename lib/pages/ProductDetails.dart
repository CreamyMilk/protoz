import 'package:flutter/material.dart';
import 'package:proto/widgets/awesomePopup.dart';

class ProductDetails extends StatelessWidget {
  Widget _buildPopupDialog(BuildContext context) {
    return AwesomePopup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          heroTag: "fer",
          // icon: Icon(Icons.money),
          backgroundColor: Colors.yellow,
          splashColor: Colors.white,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context),
            );
          },
          label: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Checkout",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "\$3.58",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          )),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Product Name",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: "fert",
                child: Image.network(
                  "https://images.orgill.com/large/7615198.JPG",
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    child: Text("Simple\n Manufature Name",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20)),
                  ),
                  Text(
                      "descrition sdfsfsfdasdf\nsdfsafasfsdfasdfasdfasdf\nsdfasfdsfsafdfasfasdfasdfsafasdf\n\n\n"),
                  // Text("Narok"),
                  // RichText(
                  //     textAlign: TextAlign.center,
                  //     text: TextSpan(children: [
                  //       TextSpan(
                  //           text: "@.",
                  //           style: TextStyle(
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.w400,
                  //               fontSize: 25)),
                  //       TextSpan(
                  //           text: "5,000",
                  //           style: TextStyle(
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.w100,
                  //               fontSize: 25)),
                  //     ])),
                ],
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
          SizedBox(height: 35),
          Column(
            children: [
              Divider(),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Quantity",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 22)),
                        SizedBox(
                          width: 3,
                        ),
                        Row(children: [
                          FloatingActionButton(
                            splashColor: Colors.black,
                            heroTag: "sdfjdfkjdsf",
                            backgroundColor: Colors.yellow,
                            child: Icon(Icons.remove, color: Colors.black),
                            mini: true,
                            onPressed: () {},
                          ),
                          Container(
                              height: 50,
                              width: 70,
                              color: Colors.white60,
                              child: Center(
                                  child: Text(
                                "01",
                                style: TextStyle(fontSize: 22),
                              ))),
                          FloatingActionButton(
                              splashColor: Colors.white,
                              heroTag: "dsfkjdsfkjdf",
                              backgroundColor: Colors.yellow,
                              child: Icon(Icons.add, color: Colors.black),
                              mini: true,
                              onPressed: () {}),
                        ]),
                        // SwitchListTile(value: false, onChanged: (bool me) {}),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Card(
                  child: ListTile(
                    dense: true,
                    visualDensity:
                        VisualDensity(horizontal: .001, vertical: .001),
                    //tileColor: Colors.pink,
                    onTap: () {},
                    title: Text("Delivery Cost",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 22)),
                    trailing: Switch(
                      activeColor: Colors.amber[900],
                      value: true,
                      onChanged: (bool value) {},
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      "\$25.97",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}

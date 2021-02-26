import 'package:flutter/material.dart';
import 'package:proto/widgets/awesomePopup.dart';

class ProductDetails extends StatelessWidget {
  Widget _buildPopupDialog(BuildContext context) {
    return AwesomePopup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Dismissible(
        key: Key("sdsd"),
        onDismissed: (direction) {},
        child: Card(
            child: Container(
                height: 50,
                child: Row(children: [
                  Hero(
                    tag: 'button 1',
                    child: InkWell(
                      onTap: () {
                        print("meme");
                      },
                      child: Container(
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          width: 90,
                          height: 50,
                          color: Color(0xfffecf0a),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text("Buy Now"),
                                Spacer(),
                                Icon(Icons.assignment_turned_in),
                              ],
                            ),
                          )),
                    ),
                  ),
                ]))),
      ),
      appBar: AppBar(
        title: Text("Fertilizers"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag:"fert",
                child: Image.network(
                  "https://images.orgill.com/large/7615198.JPG",
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
              Column(
                children: [
                  Text("Name: Oliver",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20)),
                  Text(
                      "descrition sdfsfsfdasdf\nsdfsafasfsdfasdfasdfasdf\nsdfasfdsfsafdfasfasdfasdfsafasdf\n\n\n"),
                  Text("Narok"),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Ksh.",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 25)),
                        TextSpan(
                            text: "5,000",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 25)),
                      ])),
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text("Quantity",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 22)),
                SizedBox(
                  width: 3,
                ),
                Row(children: [
                  FloatingActionButton(
                    heroTag: "sdfjdfkjdsf",
                    backgroundColor: Colors.black,
                    child: Icon(Icons.add),
                    mini: true,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    },
                  ),
                  Container(
                      height: 50,
                      width: 70,
                      color: Colors.white60,
                      child: Center(
                          child: Text(
                        "0",
                        style: TextStyle(fontSize: 22),
                      ))),
                  FloatingActionButton(
                      heroTag: "dsfkjdsfkjdf",
                      backgroundColor: Colors.black,
                      child: Icon(Icons.remove),
                      mini: true,
                      onPressed: () {}),
                ]),
              ]),
              SizedBox(
                height: 4,
              ),
            ],
          )
        ],
      )),
    );
  }
}

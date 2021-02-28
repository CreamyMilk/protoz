import 'package:flutter/material.dart';

class TransactionClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.receipt_long_sharp,
                color: Colors.grey,
              ))
        ],
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "25-Feb-2020",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            padding: EdgeInsets.only(bottom: 20),
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              HeaderAvatar(),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Text(
                      "KIJANI GROCERIES -1",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "-Ksh. 4000.00",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Chip(
                        padding: EdgeInsets.all(0),
                        backgroundColor: Colors.green[50],
                        label: Text(
                          "TRANSACTION ID:0V0DF0DDFDF",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.greenAccent,
                          ),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Till Number",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "922628",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ])),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class HeaderAvatar extends StatelessWidget {
  const HeaderAvatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[100],
      child: Stack(
        // ignore: deprecated_member_use
        overflow: Overflow.visible,
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Transform.translate(
                  offset: Offset(0, 2),
                  child: Chip(
                      backgroundColor: Colors.white,
                      visualDensity: VisualDensity(
                        horizontal: -2,
                        vertical: -2,
                      ),
                      label: Text("SendMoney")))),
          Transform.translate(
            offset: Offset(0, 25),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                foregroundColor: Colors.blue,
                child: Text("JK"),
                backgroundColor: Colors.blue[50],
                minRadius: 10,
                maxRadius: 29,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

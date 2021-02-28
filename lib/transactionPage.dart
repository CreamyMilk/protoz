import 'package:flutter/material.dart';

class TransactionClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(19)),
                      child: Icon(Icons.star_border_rounded,
                          size: 20, color: Colors.black45),
                    ),
                    Text(
                      "Favorite",
                      style: TextStyle(fontSize: 9, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(19)),
                      child: Icon(Icons.refresh_outlined,
                          size: 20, color: Colors.black87),
                    ),
                    Text(
                      "REVERSE",
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                    Text(
                      "Transcation",
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(19)),
                      child: Icon(Icons.timer, size: 20, color: Colors.black45),
                    ),
                    Text(
                      "Reminder",
                      style: TextStyle(fontSize: 9, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ]),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.receipt_long_sharp,
                color: Colors.grey[300],
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
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100.0)),
            padding: EdgeInsets.only(bottom: 20),
            height: MediaQuery.of(context).size.height * 0.42,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              HeaderAvatar(),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Text(
                      "MARGRET WAMBUI WAIRIMU",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "-Ksh. 4000.00",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 30,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Chip(
                        padding: EdgeInsets.all(0),
                        backgroundColor: Color.fromRGBO(225, 255, 255, 0.9),
                        label: Text(
                          "TRANSACTION ID:0V0DF0DDFDF",
                          style: TextStyle(
                            fontSize: 8,
                            // fontWeight: FontWeight.w100,
                            color: Colors.greenAccent[400],
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
      height: 100,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[50],
      child: Stack(
        // ignore: deprecated_member_use
        overflow: Overflow.visible,
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Transform.translate(
                  offset: Offset(0, 10),
                  child: Chip(
                      backgroundColor: Colors.white,
                      visualDensity: VisualDensity(
                        horizontal: -2,
                        vertical: -2,
                      ),
                      label: Text("SEND MONEY")))),
          Transform.translate(
            offset: Offset(0, 25),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                foregroundColor: Colors.blue,
                child: Text("MW"),
                backgroundColor: Colors.blue[50],
                minRadius: 10,
                maxRadius: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

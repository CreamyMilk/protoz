import 'package:flutter/material.dart';

class WalletsPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle collButton = TextStyle(fontSize: 15, color: Colors.black);
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        expandedHeight: 180,
        floating: true,
        pinned: true,
        centerTitle: true,
        title: Text(
          "Hello",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: false,
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(22, 82, 240, 1), Colors.white]),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text("@Kinyua",
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white54,
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text("Potential",
                            textScaleFactor: 1,
                            style:
                                TextStyle(fontSize: 9, color: Colors.white70)),
                        SizedBox(height: 3),
                        Text(
                          "KSH.15,2 Mil",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Actual",
                            textScaleFactor: 1,
                            style:
                                TextStyle(fontSize: 9, color: Colors.white70)),
                        SizedBox(height: 3),
                        Text(
                          "US.1523.34",
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  padding: EdgeInsets.all(2.0),
                  height: 40,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.greenAccent,
                        child: Transform.rotate(
                          angle: 31,
                          child: Icon(
                            Icons.arrow_circle_down_rounded,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.lightBlueAccent,
                        child: Transform.rotate(
                          angle: 31,
                          child: Icon(
                            Icons.payments,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      SliverFillRemaining(
        child: Text("Hello JOthamn"),
      )
    ]));
  }
}

import 'package:flutter/material.dart';

import 'cardsPage.dart';

// ignore: must_be_immutable
class WalletsPageBase extends StatelessWidget {
  ScrollController get n => ScrollController(initialScrollOffset: 150);
  List<Service> sampleData = [
    Service(
        imageUrl:
            "https://africasustainabilitymatters.com/wp-content/uploads/2020/11/Twiga_2.jpg",
        name: "InputSuppliers"),
    Service(
        imageUrl:
            "https://s3.amazonaws.com/newhobbyfarms.com/2020/01/9-plows-jeff-piper-flickr-e.jpg",
        name: "Machinery"),
    Service(
        imageUrl:
            "https://hingemarketing.com/wp-content/uploads/2017/08/B2B-Market-Research.png",
        name: "Market Info"),
    Service(
        imageUrl:
            "https://www.michiganstateuniversityonline.com/wp-content/uploads/sites/3/2014/04/logistics-fundamentals-supply-chain.jpg",
        name: "Logistics"),
    Service(
        imageUrl:
            "https://asmtech.com/wp-content/uploads/2018/03/What-we-do-_-Consultancy-1024x683.jpeg",
        name: "Consoltancy"),
    Service(
        imageUrl:
            "https://www.who.int/images/default-source/departments/health-financing/health-financing-and-uhc-(8).tmb-1200v.jpg?sfvrsn=add44264_6",
        name: "Financing"),
  ];
  @override
  Widget build(BuildContext context) {
    //TextStyle collButton = TextStyle(fontSize: 15, color: Colors.black);
    return Scaffold(
        body: CustomScrollView(controller: n, slivers: [
      SliverAppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ))
        ],
        expandedHeight: 200,
        floating: false,
        pinned: false,
        centerTitle: true,
        title: Text(
          "Welcome Oliver",
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
                  height: 63,
                ),
                Text("",
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
                        heroTag: "sd",
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
        child: SingleChildScrollView(
          child: NewWidget(
            sampleData: sampleData,
          ),
        ),
      )
    ]));
  }
}

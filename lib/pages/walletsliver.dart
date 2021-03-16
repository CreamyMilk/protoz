// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:proto/pages/startup/cardsPage.dart';
import 'package:proto/widgets/awesomeFab.dart';
import 'package:proto/widgets/qrScannerButton.dart';

// ignore: must_be_immutable
class WalletsPageBase extends StatelessWidget {
  //ScrollController get n => ScrollController(initialScrollOffset: 150);
  List<Services> sampleData = [
    Services(
        imageUrl:
            "https://africasustainabilitymatters.com/wp-content/uploads/2020/11/Twiga_2.jpg",
        name: "InputSuppliers"),
    Services(
        imageUrl:
            "https://s3.amazonaws.com/newhobbyfarms.com/2020/01/9-plows-jeff-piper-flickr-e.jpg",
        name: "Machinery"),
    Services(
        imageUrl:
            "https://hingemarketing.com/wp-content/uploads/2017/08/B2B-Market-Research.png",
        name: "Market Info"),
    Services(
        imageUrl:
            "https://www.michiganstateuniversityonline.com/wp-content/uploads/sites/3/2014/04/logistics-fundamentals-supply-chain.jpg",
        name: "Logistics"),
    Services(
        imageUrl:
            "https://asmtech.com/wp-content/uploads/2018/03/What-we-do-_-Consultancy-1024x683.jpeg",
        name: "Consoltancy"),
    Services(
        imageUrl:
            "https://www.who.int/images/default-source/departments/health-financing/health-financing-and-uhc-(8).tmb-1200v.jpg?sfvrsn=add44264_6",
        name: "Financing"),
  ];
  @override
  Widget build(BuildContext context) {
    //TextStyle collButton = TextStyle(fontSize: 15, color: Colors.black);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: AwesomeFab(),
        body: CustomScrollView(
            //controller: n,
            slivers: [
              WalletsAppBar(),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0,
                    crossAxisCount: 1,
                    childAspectRatio: 1.4,
                    crossAxisSpacing: 0),
                delegate:
                    SliverChildBuilderDelegate((BuildContext ctx, int index) {
                  if (index < 6) {
                    return ProductListingItem(
                      heros: index,
                      prodname: sampleData[index].name,
                      imageUrl: sampleData[index].imageUrl,
                      productID: index,
                    );
                  }
                  return null;
                }),
              ),
              // SliverFillRemaining(
              //   child: WalletsAppBar(
              //     sampleData: sampleData,
              //   ),
              // )
            ]));
  }
}

class WalletsAppBar extends StatelessWidget {
  const WalletsAppBar({
    Key key,
  }) : super(key: key);
//pishori basmati milk bread50 240,250
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/profile");
          },
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black87,
            ),
            child: Text("JK"),
          ),
        ),
      ),
      actions: [
        QrCodeScannerIcon(),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active_outlined,
              size: 19,
              color: Colors.black26,
            )),
      ],
      expandedHeight: 200,
      floating: false,
      pinned: true,
      centerTitle: true,
      title: Text(
        "Welcome",
        style: TextStyle(color: Colors.black87),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.white]),
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
                      Text("Current",
                          textScaleFactor: 1,
                          style:
                              TextStyle(fontSize: 10, color: Colors.black87)),
                      SizedBox(height: 3),
                      Text(
                        "KSH.15,255.00",
                        textScaleFactor: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Actual",
                          textScaleFactor: 1,
                          style:
                              TextStyle(fontSize: 10, color: Colors.black87)),
                      SizedBox(height: 3),
                      Text(
                        "KSH.175,275.00",
                        textScaleFactor: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w100),
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
                      heroTag: null,
                      backgroundColor: Colors.green,
                      child: Transform.rotate(
                        angle: 2,
                        child: Icon(
                          Icons.arrow_back_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/contactList");
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      heroTag: "sd",
                      mini: true,
                      backgroundColor: Colors.teal,
                      child: Transform.rotate(
                        angle: 31,
                        child: Icon(
                          Icons.payments,
                          color: Colors.white,
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
    );
  }
}

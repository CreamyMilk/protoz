import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proto/pages/startup/cardsPage.dart';
import 'package:proto/popups/addProdPopup.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:proto/widgets/qrScannerButton.dart';

// ignore: must_be_immutable
class WalletsTab extends StatelessWidget {
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
    Widget _buildPopupDialog(BuildContext context) {
    return AppProductPopUp();
  }

  @override
  Widget build(BuildContext context) {
    //TextStyle collButton = TextStyle(fontSize: 15, color: Colors.black);
    return Scaffold(
        body: CustomScrollView(

            //controller: n,
            slivers: [
              WalletsAppBar(),

              SliverList(
                delegate:
                    SliverChildBuilderDelegate((BuildContext ctx, int index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Transactions",
                        style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w500, fontSize: 25),
                      ),
                    );
                  }
                  if (index < 600) {
                    return ListTile(
                        dense: true,
                        onTap: () {
                              showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context),
                  );
                        },
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.money,
                            size: 17,
                            color: Colors.orange,
                          ),
                          minRadius: 18,
                          maxRadius: 18,
                          backgroundColor: Colors.orange[50],
                        ),
                        // heros: index,

                        title: Text("${sampleData[1].name}"),
                        subtitle: Text("John KImani"),
                        trailing: RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "+Ksh.\n",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 10.0)),
                              TextSpan(
                                  text: "5000.00",
                                  style: TextStyle(
                                      color: Colors.tealAccent[400],
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.0)),
                            ]))
                        // imageUrl: sampleData[index].imageUrl,
                        // productID: index,
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
              color: Colors.black26,
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
                colors: [Colors.tealAccent[400], Colors.tealAccent[400]]),
          ),
          child: Container(
            padding: EdgeInsets.only(left:14.0,bottom: 8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Balance",
                            textScaleFactor: 1,
                            style:
                                TextStyle(fontSize: 15, color: Colors.black87)),
                        SizedBox(height: 3),
                        Container(
                          width: screenWidth(context, percent: 0.9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "500,000.00",
                                textScaleFactor: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500),
                              ),
                              FloatingActionButton(
                                mini: true,
                                heroTag: null,
                                backgroundColor: Colors.black,
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed("/contactList");
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.swap_calls,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const YMargin(10),
                        Text(
                          "Account: 3434 5634 321",
                          textScaleFactor: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black87,
                              fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

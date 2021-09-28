import 'package:flutter/material.dart';
import 'package:proto/utils/sized_margins.dart';

class TransactionClass extends StatelessWidget {
  final String amount = "15000.00";

  const TransactionClass({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(19)),
                      child: const Icon(Icons.star_border_rounded,
                          size: 20, color: Colors.black45),
                    ),
                    const Text(
                      "Favorite",
                      style: TextStyle(fontSize: 9, color: Colors.black),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(19)),
                        child: const Icon(Icons.refresh_outlined,
                            size: 20, color: Colors.black87),
                      ),
                      const Text(
                        "REVERSE",
                        style: TextStyle(fontSize: 10, color: Colors.black),
                      ),
                      const Text(
                        "Transcation",
                        style: TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(19)),
                      child: const Icon(Icons.timer,
                          size: 20, color: Colors.black45),
                    ),
                    const Text(
                      "Reminder",
                      style: TextStyle(fontSize: 9, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const Spacer(),
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
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "25-Feb-2020",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/transaction");
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.0)),
              padding: const EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height * 0.42,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                const HeaderAvatar(),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      const Text(
                        "KINYUA JOTHAM",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 18),
                      ),
                      const YMargin(10),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            const TextSpan(
                                text: "+Ksh.",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15.0)),
                            TextSpan(
                                text: amount.toString().replaceAllMapped(
                                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match m) => '${m[1]},'),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 24.0)),
                          ])),
                      const YMargin(10),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Transacrion ID",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w100),
                        ),
                        Text(
                          "0xLGODAT",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderAvatar extends StatelessWidget {
  const HeaderAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.grey[50]!, Colors.grey[100]!, Colors.grey[50]!]),
      ),
      width: screenWidth(context),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Transform.translate(
                  offset: const Offset(0, 10),
                  child: const Chip(
                      backgroundColor: Colors.white,
                      visualDensity: VisualDensity(
                        horizontal: -2,
                        vertical: -2,
                      ),
                      label: Text("SEND MONEY")))),
          Transform.translate(
            offset: const Offset(0, 25),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                foregroundColor: Colors.blue,
                child: const Text("JK"),
                backgroundColor: Colors.blue[50],
                minRadius: 15,
                maxRadius: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

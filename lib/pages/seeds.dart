import 'package:flutter/material.dart';

class SeedsExpansion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Image.network(
                "https://4.imimg.com/data4/LN/CT/MY-3479641/wheat-seeds-bags-500x500.png",
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
              ),
              Column(
                children: [
                  Text("John Kimani",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20)),
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
                            text: "9,750",
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
          SizedBox(height: 5),
          Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text("Contact",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 22)),
                SizedBox(
                  width: 3,
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  color: Colors.white,
                  child: Text(
                    "0797345634",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                ),
              ]),
              SizedBox(
                height: 4,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text("Location",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 22)),
                SizedBox(
                  width: 3,
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  color: Colors.white,
                  child: Text(
                    "Machakos",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                ),
              ]),
            ],
          )
        ],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:proto/utils/sized_margins.dart';
import 'package:proto/widgets/add_money_bottom_sheet.dart';

class ContactsListPage extends StatelessWidget {
  final List<Color> lightColors = [
    const Color(0xfffe8fff),
    Colors.pink[50]!,
    Colors.deepPurple[50]!,
  ];

  final List<Color> foregroundColor = [
    Colors.blue,
    Colors.pink,
    Colors.deepPurple[900]!,
  ];

  ContactsListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        bottom: PreferredSize(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: TextField(
                decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                        left: 15, bottom: 11, top: 17, right: 15),
                    filled: true,
                    hintText: "Search Contacts",
                    prefixIcon: const Icon(Icons.search),
                    fillColor: Colors.grey[100]),
              )),
          preferredSize: const Size(0.0, 60.0),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.grey),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Send Money",
          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black87),
        ),
      ),
      body: SizedBox(
        height: screenHeight(context),
        child: ListView(
          children: [
            const YMargin(10),
            Column(
              children: [
                StyledActionListTile(
                  color: Colors.blue[600]!,
                  icondata: Icons.dialpad_rounded,
                  textColor: Colors.blue[900]!,
                  myText: "Send to Phone Number",
                  ontap: () {
                    Navigator.of(context).pushNamed("/enterphone");
                  },
                ),
                StyledActionListTile(
                  color: Colors.greenAccent[400]!,
                  icondata: Icons.phone_android_rounded,
                  textColor: Colors.greenAccent[700]!,
                  myText: "Send To Mpesa",
                  ontap: () {
                    // Navigator.of(context).pushNamed("/enterphone");
                  },
                ),
                StyledActionListTile(
                  color: Colors.pink,
                  icondata: Icons.qr_code_rounded,
                  textColor: Colors.pinkAccent[700]!,
                  myText: "Scan QR CODE",
                  ontap: () {
                    Navigator.of(context).pushNamed("/qrscanner");
                  },
                ),
                StyledActionListTile(
                  color: Colors.black,
                  icondata: Icons.clean_hands_rounded,
                  textColor: Colors.black,
                  myText: "Deposit Into Wallet",
                  ontap: () {
                    depositModalBottomSheet(context);
                  },
                ),
              ],
            ),
            const Divider(),
            const Padding(
                padding: EdgeInsets.only(left: 15, bottom: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Personal Contacts",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ))),
            ListView.builder(
                physics: const ScrollPhysics(),
                itemCount: 0,
                shrinkWrap: true,
                itemExtent: 60,
                itemBuilder: (context, index) {
                  return ListTile(
                    isThreeLine: true,
                    leading: Transform.translate(
                      offset: const Offset(0, -5),
                      child: CircleAvatar(
                        foregroundColor: foregroundColor[2],
                        child: const Text(
                          "BR",
                          style: TextStyle(fontSize: 10),
                        ),
                        minRadius: 20,
                        maxRadius: 20,
                        backgroundColor: lightColors[2],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed("/enteramount");
                    },
                    contentPadding:
                        const EdgeInsets.only(left: 10, bottom: 12.0),
                    minLeadingWidth: 30,
                    // horizontalTitleGap: 0.1,
                    // minVerticalPadding: 0.0,
                    // visualDensity: VisualDensity(horizontal: .1,vertical: 0.1),
                    dense: true,
                    title: const Text("Bob Ross"),
                    subtitle: const Text("0781212121"),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class StyledActionListTile extends StatelessWidget {
  const StyledActionListTile({
    Key? key,
    required this.color,
    required this.icondata,
    required this.textColor,
    required this.myText,
    required this.ontap,
  }) : super(key: key);
  final Color color;
  final Color textColor;
  final IconData icondata;
  final String myText;

  final void Function() ontap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white70,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(15.0), //or 15.0
        child: Container(
          width: 40,
          height: 40,
          child: Icon(
            icondata,
            size: 17,
            color: Colors.white,
          ),
          color: color,
        ),
      ),
      onTap: ontap,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 12.0),
      //minLeadingWidth: 30,
      dense: true,
      title: Text(
        myText,
        style: TextStyle(color: textColor),
      ),
    );
  }
}

class FavoriteTile extends StatelessWidget {
  const FavoriteTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/enteramount");
      },
      child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CircleAvatar(
                foregroundColor: Colors.blue,
                child: const Text("JK", style: TextStyle(fontSize: 11)),
                backgroundColor: Colors.blue[50],
                minRadius: 18,
                maxRadius: 18,
              ),
              const YMargin(2),
              const Text("John",
                  style: TextStyle(
                    fontSize: 10,
                  ))
            ],
          )),
    );
  }
}

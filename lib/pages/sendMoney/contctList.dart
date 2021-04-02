import 'package:flutter/material.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:proto/widgets/qrScannerButton.dart';


class ContactsListPage extends StatelessWidget {
  final List<Color> lightColors = [
    Color(0xfffe8fffa),
    Colors.pink[50],
    Colors.deepPurple[50],];

   final List<Color> foregroundColor= [
     Colors.blue,
    Colors.pink,
    Colors.deepPurple[900],];
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
                decoration: new InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 17, right: 15),
                    filled: true,
                    hintText: "Search Contacts",
                    prefixIcon: Icon(Icons.search),
                    fillColor: Colors.grey[100]),
              )),
          preferredSize: Size(0.0, 60.0),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.grey),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Send Money",
          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black87),
        ),
      ),
      body: Container(
        height: screenHeight(context),
        child: ListView(
          children: [
            Padding(padding:EdgeInsets.only(left:10),child: Align(alignment: Alignment.centerLeft, child: Text("Favorites"))),
            Container(
              height: 80,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return FavoriteTile();
                  }),
            ),
            Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.dialpad,
                      size: 17,
                      color: Colors.white,
                    ),
                    minRadius: 18,
                    maxRadius: 18,
                    backgroundColor: Colors.blue[600],
                  ),
                  
                  onTap: () {
                    Navigator.of(context).pushNamed("/enteramount");
                  },
                  contentPadding: EdgeInsets.only(left: 10, bottom: 12.0),
                  minLeadingWidth: 30,
                  dense: true,
                  title: Text("Enter Phone Number",style: TextStyle(color:Colors.blue[900]),),
                ),                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.phone_android_sharp,
                      size: 17,
                      color: Colors.white,
                    ),
                    minRadius: 18,
                    maxRadius: 18,
                    backgroundColor: Colors.greenAccent[400],
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/enteramount");
                  },
                  contentPadding: EdgeInsets.only(left: 10, bottom: 12.0),
                  minLeadingWidth: 30,
                  dense: true,
                  title: Text("Send To Mpesa",style: TextStyle(color:Colors.greenAccent[700]),),
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.qr_code_rounded,
                      size: 17,
                      color: Colors.white,
                    ),
                    minRadius: 18,
                    maxRadius: 18,
                    backgroundColor: Colors.pink,
                  ),
                  onTap: () {
                    initateScan(context);
                  },
                  contentPadding: EdgeInsets.only(left: 10, bottom: 12.0),
                  minLeadingWidth: 30,
                  dense: true,
                  title: Text("Scan QR CODE",style: TextStyle(color:Colors.pinkAccent[700])),
                ),
              ],
            ),
             Padding(padding:EdgeInsets.only(left:10),child: Align(alignment: Alignment.centerLeft, child: Text("All Contacts"))),
            ListView.builder(
               physics: ScrollPhysics(),
                itemCount: 50,
                shrinkWrap: true,
                itemExtent: 60,
                itemBuilder: (context, index) {
                  return ListTile(
                    isThreeLine: true,
                    leading: Transform.translate(
                      offset: const Offset(0, -5),
                      child: CircleAvatar(
                        foregroundColor: foregroundColor[index %3],
                        child: Text(
                          "JK",
                          style: TextStyle(fontSize: 10),
                        ),
                        minRadius: 20,
                        maxRadius: 20,
                        backgroundColor: lightColors[index % 3],
                      ),
                    ),
                    onTap: () {
                        Navigator.of(context).pushNamed("/enteramount");
                    },
                    contentPadding: EdgeInsets.only(left: 10, bottom: 12.0),
                    minLeadingWidth: 30,
                    // horizontalTitleGap: 0.1,
                    // minVerticalPadding: 0.0,
                    // visualDensity: VisualDensity(horizontal: .1,vertical: 0.1),
                    dense: true,
                    title: Text("Jotham Kinyua"),
                    subtitle: Text("0797978252"),
                  );
                }),
          ],
        ),
      ),
    );
  }
}



class FavoriteTile extends StatelessWidget {
  const FavoriteTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          Navigator.of(context).pushNamed("/enteramount");
      }
      ,
      child: Container(
          margin: EdgeInsets.all(8.0),
          child: Column(
            children: [
            CircleAvatar(
                foregroundColor: Colors.blue,
                child: Text("JK",style: TextStyle(fontSize: 11)),
                backgroundColor: Colors.blue[50],
                minRadius: 18,
                maxRadius: 18,
              ),
              const YMargin(2),
              Text("John",
                  style: TextStyle(
                    fontSize: 10,
                  ))
            ],
          )),
    );
  }
}

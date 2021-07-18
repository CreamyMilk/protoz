import 'package:flutter/material.dart';

class BLPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
        elevation: 0,
        centerTitle: true,
        title: Text("BD page",style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Divider(),
          ListTile(
            dense: true,
              title: Text(
                "FAQ",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,),
              onTap: () {
                Navigator.of(context).pushNamed("/youtube");
              }),
          Divider(),
          ListTile(
              title: Text(
                "Training Videos",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
                           trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,),
              onTap: () {
                print("Oya");
              }),
          Divider(),
          ListTile(
              title: Text(
                "Consoltants",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
                           trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,),
              onTap: () {
                Navigator.of(context).pushNamed("/blconsoltants");
              }),
          Divider(),
        ],
      ),
    );
  }
}

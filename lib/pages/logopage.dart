import 'package:flutter/material.dart';

class LogoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("/login");
        },
      ),
      body: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:Hero(tag:"logo",child: Icon(Icons.filter_drama,size: 100,),),
          ),),
    );
  }
}
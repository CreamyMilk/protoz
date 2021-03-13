import 'package:flutter/material.dart';

class LogoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("/startup");
        },
      ),
      body: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:Hero(tag:"logo",child: Icon(Icons.toll_outlined,size: 100,),),

          ),),
    );
  }
}
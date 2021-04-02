import 'package:flutter/material.dart';

class LogoPage extends StatefulWidget {
  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  void autoNavigate(BuildContext context){
    //Handle Token Confirmation here
    Future.delayed(Duration(seconds: 2),(){
          Navigator.of(context).pushReplacementNamed("/startup");
  });
  
  }
  @override
  Widget build(BuildContext context) {
    autoNavigate(context);
    return Scaffold(
      body: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:Hero(tag:"logo",child: Icon(Icons.toll_outlined,size: 100,),),

          ),),
    );
  }
}

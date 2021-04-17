import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import "package:proto/constants.dart" as Constants;

class LogoPage extends StatefulWidget {
  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  Box<dynamic> hiveBox =  Hive.box(Constants.UserBoxName);
  void autoNavigate(BuildContext context){
    bool isLoggedIn = hiveBox.get(Constants.IsLoggedInStore,defaultValue:false);
    //Handle Token Confirmation here
    Future.delayed(Duration(seconds: 3),(){
       !isLoggedIn?
        Navigator.of(context).pushReplacementNamed("/startup")
       : Navigator.of(context).pushReplacementNamed("/home");
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

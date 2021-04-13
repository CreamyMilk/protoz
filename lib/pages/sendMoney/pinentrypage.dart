import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:proto/widgets/keypadwidget.dart';

class EnterPinPage extends StatefulWidget {
  @override
  _EnterPinPageState createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  String pincode = "";

  @override
  void initState() {
    pincode = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Enter Pin",
          
          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black87),
        ),
      ),
      body: Column(children: [
        Spacer(),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: "$pincode",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 35.0)),
            ])),
        Spacer(),
         AnimatedContainer(
          duration: Duration(seconds: 1),
          height: 50,
          width: screenWidth(context, percent: 0.8),
          decoration: BoxDecoration(
            color:
                pincode.length ==4 ? Colors.greenAccent[400] : Colors.grey[200],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400].withOpacity(0.3),
                  offset: Offset(0, 13),
                  blurRadius: 30)
            ],
          ),
          // ignore: deprecated_member_use
          child: FlatButton(
                        onPressed:pincode.length > 1?(){
                          Navigator.of(context).pushNamed("/pin");
                        } : (){},
            color: Colors.transparent,
            child: Text(
              pincode.length != 4 ?  "Enter Pin ":"Verifying ->",
              style: GoogleFonts.nunito(
                  color: pincode.length == 4 ? Colors.white : Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        NumericKeyboard(
            rightButtonFn: () {
              if (pincode.length > 0) {
                pincode = pincode.substring(0, pincode.length - 1);
                setState(() {
                  pincode = pincode;
                });
              }
            },
            rightIcon:
                Icon(Icons.backspace_outlined, size: 20, color: Colors.black54),
            onKeyboardTap: (String text) {
              print(text);
              setState(
                () {
                  if (pincode.length < 4) {
                    pincode += "*";
                  }
                  if (pincode.length == 4) {
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.of(context).pushNamed("/transaction");
                    });
                  }
                },
              );
            })
      ]),
    );
  }
}

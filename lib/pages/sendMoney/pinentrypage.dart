import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:proto/constants.dart';
import 'package:proto/popups/errorPopup.dart';
import 'package:proto/popups/successfulSent.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:proto/widgets/keypadwidget.dart';

class EnterPinPage extends StatefulWidget {
  @override
  _EnterPinPageState createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  String pincode = "";
  bool loading = false;
  Box<dynamic> box;
  @override
  void initState() {
    box = Hive.box(Constants.UserBoxName);
    pincode = "";
    loading = false;
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
      body: Column(
        children: [
          Spacer(),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: "$pincode",
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 10,
                        fontWeight: FontWeight.w400,
                        fontSize: 35.0)),
              ])),
          Spacer(),
          loading
              ? CircularProgressIndicator()
              : AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: 50,
                  width: screenWidth(context, percent: 0.8),
                  decoration: BoxDecoration(
                    color: pincode.length == 4
                        ? Colors.greenAccent[400]
                        : Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[400].withOpacity(0.3),
                          offset: Offset(0, 13),
                          blurRadius: 30)
                    ],
                  ),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: pincode.length > 1
                        ? () {
                            setState(() {
                              loading = true;
                            });
                            _sendMoneyRequest(pincode, context);
                          }
                        : () {},
                    color: Colors.transparent,
                    child: Text(
                      pincode.length != 4 ? "Enter Pin " : "Send Now  ->",
                      style: GoogleFonts.nunito(
                          color: pincode.length == 4
                              ? Colors.white
                              : Colors.blueGrey,
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
              rightIcon: Icon(Icons.backspace_outlined,
                  size: 20, color: Colors.black54),
              onKeyboardTap: (String text) {
                print(text);
                setState(
                  () {
                    if (pincode.length < 4) {
                      pincode += "*";
                    }
                  },
                );
              })
        ],
      ),
    );
  }

  Future _sendMoneyRequest(String pin, BuildContext ctx) async {
    var box = Hive.box(Constants.UserBoxName);
    try {
      final response = await post(
        (Constants.API_BASE + "wallet/sendmoney"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode(
          //ensure that the user has bothe the socketID and the USER ID
          {
            "from": box.get(Constants.WalletNameStore),
            "to": Constants.zerototwo(box.get(Constants.ReceiverNumberStore)),
            "amount": int.parse(box.get(Constants.AmountToSendStore)),
            "pin": pin
          },
        ),
      );
      var myjson = json.decode(response.body);
      print(myjson);
      if (myjson["status"] == 0) {
        setState(() {
          loading = false;
        });
        box.put(Constants.BalanceStore, myjson["newbalance"]);
        showCupertinoDialog(
            context: ctx,
            builder: (BuildContext context) => SuccesfulSentMoneyPopUp());
        // Navigator.of(ctx).pushNamed("/home");
      } else {
        setState(() {
          loading = false;
        });

        showCupertinoDialog(
            context: ctx,
            builder: (BuildContext context) => CannontReigsterPopUp(
                message: "Error while sending payment request"));
      }
    } catch (SocketException) {
      setState(() {
        loading = false;
      });

      showCupertinoDialog(
          context: ctx,
          builder: (BuildContext context) => CannontReigsterPopUp(message: ""));
    }
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:proto/constants.dart';
import 'package:proto/pages/sendMoney/confirmdetails.dart';
import 'package:proto/popups/error_popup.dart';
import 'package:proto/popups/unregisterd_popup.dart';
import 'package:proto/utils/sized_margins.dart';
import 'package:proto/utils/type_extensions.dart';
import 'package:proto/widgets/keypadwidget.dart';

class EnterAmountPage extends StatefulWidget {
  const EnterAmountPage({Key? key}) : super(key: key);

  @override
  _EnterAmountPageState createState() => _EnterAmountPageState();
}

class _EnterAmountPageState extends State<EnterAmountPage> {
  String amount = "";
  late Box<dynamic> box;
  bool loading = false;
  @override
  void initState() {
    box = Hive.box(Constants.UserBoxName);
    amount = "0";
    loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Amount",
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
      body: Column(children: [
        const Spacer(),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              const TextSpan(
                  text: "Ksh.",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0)),
              TextSpan(
                  text: amount.addCommas,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 35.0)),
            ])),
        const Spacer(),
        loading
            ? const CircularProgressIndicator()
            : AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: 50,
                width: screenWidth(context, percent: 0.8),
                decoration: BoxDecoration(
                  color: amount.length > 1
                      ? Colors.greenAccent[400]
                      : Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[400]!.withOpacity(0.3),
                        offset: const Offset(0, 13),
                        blurRadius: 30)
                  ],
                ),
                child: TextButton(
                  onPressed: amount.length > 1
                      ? () async {
                          await box.put(Constants.AmountToSendStore, amount);
                          _getRatesAndUserName(context);
                          setState(() {
                            loading = true;
                          });
                        }
                      : () {},
                  child: Text(
                    amount.length > 1 ? "Continue   ->" : "Enter Amount",
                    style: GoogleFonts.nunito(
                        color:
                            amount.length > 1 ? Colors.white : Colors.blueGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
        NumericKeyboard(
            rightButtonFn: () {
              if (amount.length == 1) {
                setState(() {
                  amount = "0";
                });
              }
              if (amount.length > 1) {
                amount = amount.substring(0, amount.length - 1);
                setState(() {
                  amount = amount;
                });
              }
            },
            rightIcon: const Icon(Icons.backspace_outlined,
                size: 20, color: Colors.black54),
            onKeyboardTap: (String text) {
              //print(text);
              setState(
                () {
                  if (amount == "0") {
                    amount = text;
                  } else if (amount.length < 12) {
                    amount += text;
                  }
                },
              );
            })
      ]),
    );
  }

  Future _getRatesAndUserName(ctx) async {
    var box = Hive.box(Constants.UserBoxName);
    try {
      final response = await post(
        Uri.parse(Constants.API_BASE + "wallet/verify"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode(
          //ensure that the user has bothe the socketID and the USER ID
          {
            "phonenumber":
                Constants.zerototwo(box.get(Constants.ReceiverNumberStore)),
            "amount": int.parse(box.get(Constants.AmountToSendStore))
          },
        ),
      );
      var myjson = json.decode(response.body);
      if (myjson["status"] == 0) {
        setState(() {
          loading = false;
        });
        Navigator.of(ctx).push(MaterialPageRoute(builder: (contxt) {
          return ConfirmPage(
            amount: int.parse(box.get(Constants.AmountToSendStore)),
            receiverName: myjson["username"],
            fees: myjson["rates"],
            receiverPhone: box.get(Constants.ReceiverNumberStore),
          );
        }));
        // Navigator.of(ctx).pushNamed("/home");
      } else if (myjson["status"] == -19) {
        setState(() {
          loading = false;
        });
        showCupertinoDialog(
            context: ctx,
            builder: (BuildContext context) => const UnregisteredPopUp());
      } else {
        setState(() {
          loading = false;
        });

        showCupertinoDialog(
            context: ctx,
            builder: (BuildContext context) => CustomErrorPopup(
                  message: response.body,
                ));
      }
    } catch (err) {
      setState(() {
        loading = false;
      });

      showCupertinoDialog(
          context: ctx, builder: (BuildContext context) => const ErrorPopUP());
    }
  }
}

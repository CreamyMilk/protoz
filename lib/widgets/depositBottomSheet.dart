import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void settingModalBottomSheet(context, amountDue) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.0), topRight: Radius.circular(0.0)),
    ),
    context: context,
    builder: (BuildContext context) {
      return PaymentBottomSheet();
    },
  );
}

class PaymentTile extends StatefulWidget {
  @override
  _PaymentTileState createState() => _PaymentTileState();
}

class _PaymentTileState extends State<PaymentTile> {
  bool _enabled = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          minWidth: 25,
          height: 30,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: _enabled
                  ? BorderSide(color: Colors.red)
                  : BorderSide(color: Colors.grey)),
          elevation: 3.0,
          padding: EdgeInsets.all(10.0),
          color: Colors.white,
          onPressed: () {
            setState(() {
              _enabled = !_enabled;
            });
          },
          child: ColorFiltered(
            colorFilter: _enabled
                ? ColorFilter.mode(
                    Colors.transparent,
                    BlendMode.multiply,
                  )
                : ColorFilter.matrix(<double>[
                    0.2126,
                    0.7152,
                    0.0722,
                    0,
                    0,
                    0.2126,
                    0.7152,
                    0.0722,
                    0,
                    0,
                    0.2126,
                    0.7152,
                    0.0722,
                    0,
                    0,
                    0,
                    0,
                    0,
                    1,
                    0,
                  ]),
            child: Container(
              width: 45,
              height: 35,
              child: Image.asset(
                'assets/mpesa.png',
                fit: BoxFit.scaleDown,
                width: 10,
                height: 5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future _sendPayment(mobile, amountDue, accName, ctx) async {
  //final FirebaseMessaging _fcm = FirebaseMessaging();
  //v2 work with paymentapi responses

  try {
    final response = await http.post(
      ("https://googlesecureotp.herokuapp.com/" + "payment"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        //ensure that the user has bothe the socketID and the USER ID
        {
          "phonenumber": mobile,
          "amount": amountDue,
          "userID": accName ?? "Error",
          "socketID": "mee",
        },
      ),
    );
    print("$response");
  } catch (SocketException) {
    print("msEE HAUNA WIFI");
    showDialog(
      //Text(message['notification']['title']
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: AspectRatio(
          aspectRatio: 1.5,
          child: Text("ap"),
        ),
      ),
    );
  }
}

String validatePassword(String value) {
  if (!(value.length > 9) && value.isNotEmpty) {
    if (value[0] != "0") {
      return "Mobile number should be in the format 07xx";
    }
    return null;
  }
  return null;
}

String convertTo07(String f) {
  String no;
  String pl;
  String t5;
  no = f.replaceAll(new RegExp(r"\s+"), "");
  pl = no.replaceAll(new RegExp(r"\+"), "");
  t5 = pl.replaceAll(new RegExp(r"2547"), "07");
  return t5;
}

class PaymentBottomSheet extends StatefulWidget {
  @override
  _PaymentBottomSheetState createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  final TextEditingController _testcontroller = TextEditingController();
  String mobile;
  String amountDue;
  String visualAmount;
  String accountName;
  @override
  void initState() {
    var temp = {
      'rentDue': 0,
      'account': 'err',
      'month': "null",
      "rentStatus": false
    }; //Add default for non complains
    mobile = "";
    amountDue = temp["rentDue"].toString();
    accountName = temp["account"];
    visualAmount = amountDue.replaceAllMapped(
        new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
        decoration: BoxDecoration(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_downward),
                Text(
                  "Rent Payment",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                ),
                SizedBox()
              ],
            ),
            Divider(),
            SizedBox(height: 5),
            Row(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Amount:",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "$visualAmount",
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Number:",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        mobile,
                        style: TextStyle(
                            fontWeight: FontWeight.w100, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Payment Method",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PaymentTile(),
                // SizedBox(
                //   width: 10,
                // ),
                // PaymentTile(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Running low on Cash ?",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              ),
            ),
            TextField(
              autofocus: true,
              onChanged: (value) {
                print(value);
                setState(() {
                  mobile = value;
                });
              },
              controller: _testcontroller,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: IconButton(
                  icon: Icon(Icons.contacts),
                  onPressed: () async {
//                          await FlutterContactPicker.pickPhoneContact();

                    setState(() {
                      _testcontroller.text = convertTo07("25479888888");
                      mobile = "";
                    });
                  },
                ),
                border: OutlineInputBorder(gapPadding: 0.5),
                hintText: 'Ask somone else to pay',
                errorText: validatePassword(_testcontroller.text),
                prefixText: "",
              ),
              keyboardType: TextInputType.numberWithOptions(),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: MaterialButton(
                  height: 45,
                  minWidth: MediaQuery.of(context).size.width * .95,
                  onPressed: () async {
                    Navigator.pop(context);
                    await _sendPayment(mobile, amountDue, accountName, context);
                  },
                  color: Colors.black,
                  child: Text(
                    "Pay $amountDue",
                    style: TextStyle(color: Colors.white),
                  ),
                  autofocus: true,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

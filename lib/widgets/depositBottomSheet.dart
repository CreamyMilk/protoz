import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proto/models/paymentResponseModel.dart';
import 'package:proto/popups/registrationPopup.dart';

void kplzModalBottomSheet(context, amountDue) {
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

String convertTo07(String f) {
  String no;
  String pl;
  String t5;
  no = f.replaceAll(new RegExp(r"\s+"), "");
  pl = no.replaceAll(new RegExp(r"\+"), "");
  t5 = pl.replaceAll(new RegExp(r"2547"), "07");
  return t5;
}

void choiceAction(String choice) {
  print(choice);
  Navigator.of(null).pushNamed('/randomUser');
}

String validateAmount(String value) {
  if (!(value.length > 4) && value.isNotEmpty) {
    if (value[0] != "0") {
      return "Allow purchases up to Ksh 9,999";
    }
    return null;
  }
  return null;
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

class PaymentBottomSheet extends StatefulWidget {
  @override
  _PaymentBottomSheetState createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  // Box<dynamic> userHiveBox;
  final TextEditingController _phoneficontroller = TextEditingController();
  final TextEditingController _amountficontroller = TextEditingController();
  String mobile="0";
  String amountDue = "1";
  String visualAmount="1";
  String accountName="test";
  // @override
  // void initState() {
  //   userHiveBox = Hive.box('user');
  //   var temp = userHiveBox.get('rent', defaultValue: {
  //     'rentDue': 0,
  //     'account': 'err',
  //     'month': "null",
  //     "rentStatus": false
  //   }); //Add default for non complains
  //   mobile = userHiveBox.get('mobile', defaultValue: "");
  //   accountName = "#po" + temp["account"];
  //   visualAmount = amountDue.replaceAllMapped(
  //       new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  //   super.initState();
  // }

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
                  Icon(Icons.bolt),
                  Text(
                    "Wallet Deposit",
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
                          "Ksh :",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "$visualAmount",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
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
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          mobile,
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     "Select Payment Method",
              //     style: TextStyle(fontWeight: FontWeight.w800),
              //   ),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     PaymentTile(),
              //     // SizedBox(
              //     //   width: 10,
              //     // ),
              //     // PaymentTile(),
              //   ],
              // ),
              SizedBox(
                height: 20,
              ),

              TextField(
                autofocus: true,
                onChanged: (value) {
                  print(value);
                  setState(() {
                    visualAmount = value;
                    amountDue = value;
                  });
                },
                controller: _amountficontroller,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(gapPadding: 0.9),
                  labelText: 'Amount',
                  hintText: 'In shillings',
                  errorText: validateAmount(_phoneficontroller.text),
                  prefixText: "",
                ),
                keyboardType: TextInputType.numberWithOptions(),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Running low on Cash ?",
                  style: TextStyle(color:Colors.white,fontWeight: FontWeight.w400, fontSize: 15),

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
                controller: _phoneficontroller,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(gapPadding: 0.2),
                  hintText: 'Enter Phone Number',
                  errorText: validatePassword(_phoneficontroller.text),
                  prefixText: "",
                ),
                keyboardType: TextInputType.numberWithOptions(),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: MaterialButton(
                    height: 40,
                    minWidth: MediaQuery.of(context).size.width * .95,
                    onPressed: () async {
                      await _sendPayment(
                          mobile, amountDue, accountName, context);
                    },
                    color: Colors.black,
                    child: Text(
                      "Deposit $amountDue",
                      style: TextStyle(color: Colors.white),
                    ),
                    autofocus: true,
                  ),
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }



Future _sendPayment(mobile, amountDue, accName, ctx) async {
  Widget _buildPopupDialog(BuildContext context) {
    return RegistrationPopUp();
  }

  PaymentResponse data;

  try {
      Navigator.pop(ctx);
    String fcmToken = "no";
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
          "notifToken": fcmToken
        },
      ),
    );
    print("$accName");
    var myjson = json.decode(response.body);
    print(fcmToken);
    print("Mobile $mobile");
    print("Amount $amountDue");
    data = PaymentResponse.fromJson(myjson);
    print(data.paymentCode);
    if (data.description=="0"){

      print("Req Sent Well"); 
    }
  } catch (SocketException) {
    print("msEE HAUNA WIFI");
    showCupertinoDialog(
      context: ctx,
      builder: (BuildContext context) => _buildPopupDialog(context),
    );
  }
}
}
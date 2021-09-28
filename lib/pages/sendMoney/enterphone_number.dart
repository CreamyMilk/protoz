import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:proto/constants.dart';
import 'package:proto/utils/sized_margins.dart';
import 'package:proto/widgets/keypadwidget.dart';

class EnterPhoneNumberPage extends StatefulWidget {
  const EnterPhoneNumberPage({Key? key}) : super(key: key);

  @override
  _EnterPhoneNumberPageState createState() => _EnterPhoneNumberPageState();
}

class _EnterPhoneNumberPageState extends State<EnterPhoneNumberPage> {
  String phoneNumber = "";
  late Box<dynamic> box;
  @override
  void initState() {
    phoneNumber = "07";
    box = Hive.box(Constants.UserBoxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Mobile Number",
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
      body: Column(children: [
        const Spacer(),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              const TextSpan(
                  text: "",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0)),
              TextSpan(
                  text: phoneNumber,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 35.0)),
            ])),
        const Spacer(),
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          height: 50,
          width: screenWidth(context, percent: 0.8),
          decoration: BoxDecoration(
            color: phoneNumber.length > 9
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
            onPressed: phoneNumber.length > 9
                ? () {
                    box.put(Constants.ReceiverNumberStore, phoneNumber);
                    Navigator.of(context).pushNamed("/enteramount");
                  }
                : () {},
            child: Text(
              phoneNumber.length > 9 ? "Continue  ->" : "Enter Phone Number",
              style: GoogleFonts.nunito(
                  color:
                      phoneNumber.length > 9 ? Colors.white : Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        NumericKeyboard(
            rightButtonFn: () {
              if (phoneNumber.length == 1) {
                setState(() {
                  phoneNumber = "07";
                });
              }
              if (phoneNumber.length > 1) {
                phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
                setState(() {
                  phoneNumber = phoneNumber;
                });
              }
            },
            rightIcon: const Icon(Icons.backspace_outlined,
                size: 20, color: Colors.black54),
            onKeyboardTap: (String text) {
              //print(text);
              setState(
                () {
                  if (phoneNumber == "0") {
                    phoneNumber += text;
                  } else if (phoneNumber.length < 10) {
                    phoneNumber += text;
                  }
                },
              );
            })
      ]),
    );
  }
}

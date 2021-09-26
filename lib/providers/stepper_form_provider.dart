import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:proto/constants.dart';
import 'package:proto/popups/error_popup.dart';
import 'package:proto/popups/registration_popup.dart';

class KraFormProvider extends ChangeNotifier {
  TextEditingController fnController = TextEditingController();
  TextEditingController mnContorller = TextEditingController();
  TextEditingController lnController = TextEditingController();
  GlobalKey<FormState> nameKey = GlobalKey<FormState>();

  TextEditingController yController = TextEditingController();
  TextEditingController mController = TextEditingController();
  TextEditingController dController = TextEditingController();
  GlobalKey<FormState> birthKey = GlobalKey<FormState>();

  TextEditingController idController = TextEditingController();
  GlobalKey<FormState> idKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController clonePasswordController = TextEditingController();
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  TextEditingController cnController = TextEditingController();
  TextEditingController phController = TextEditingController();
  GlobalKey<FormState> phoneKey = GlobalKey<FormState>();
  GlobalKey<FormState> kraKey = GlobalKey<FormState>();

  TextEditingController locationController = TextEditingController();
  TextEditingController countyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController altPhoneController = TextEditingController();
  int activePage = 0;
  bool isLoading = false;

  late String firstName;
  late String middleName;
  late String lastName;
  late String day;
  late String month;
  late String idd;
  late String year;
  late String countrycode;
  late String phoneNumber;
  late String password;
  late String role = "DEFAULT";
  late bool terms = true;

  void nameFields(String a, String b) {
    firstName = a;
    lastName = b;
    notifyListeners();
  }

  void ageFields(String d, String m, String y) {
    day = d;
    month = m;
    year = y;
    notifyListeners();
  }

  void kraFields(String t) {
    role = t;
    notifyListeners();
  }

  void increment() {
    activePage++;
    notifyListeners();
  }

  void decrement() {
    activePage--;
    notifyListeners();
  }

  void nfSubmit() {
    if (nameKey.currentState!.validate()) {
      firstName = fnController.text;
      middleName = mnContorller.text;
      lastName = lnController.text;
      increment();
      //print("Text fiels Values are $t $d");
    }
  }

  void passwordFormSubmit() {
    if (passwordFormKey.currentState!.validate()) {
      password = passwordController.text;
      increment();
    }
  }

  void idSubmit() {
    if (idKey.currentState!.validate()) {
      year = yController.text;
      month = mController.text;
      day = dController.text;
      increment();
      //print("Text fiels Values are $t $d");
    }
  }

  void bfSubmit() {
    if (birthKey.currentState!.validate()) {
      year = yController.text;
      month = mController.text;
      day = dController.text;
      increment();
      //print("Text fiels Values are $t $d");
    }
  }

  String getBirth() {
    return 'Y-$year M-$month D-$day';
  }

  void phSubmit() {
    if (phoneKey.currentState!.validate()) {
      countrycode = cnController.text;
      phoneNumber = phController.text;
      increment();
      //print("Text fiels Values are $t $d");
    }
  }

  void finalSubmit() {
    phoneNumber = phController.text;
  }

  void krSubmit() {
    if (role.length > 6) {
      increment();
    }
    //print("Text fiels Values are $t $d");
  }

  void termsAccept(value) {
    // terms = value;
    notifyListeners();
  }

  void newSingleSubmit() {
    firstName = fnController.text;
    middleName = mnContorller.text;
    lastName = lnController.text;
    password = passwordController.text;
    phoneNumber = phController.text;
    idd = idController.text;
  }

  Future zendPayment(BuildContext ctx) async {
    String accName = phoneNumber;
    isLoading = true;
    notifyListeners();
    Widget _buildPopupDialog(BuildContext context) {
      return RegistrationPopUp();
    }

    String zerototwo(String phone) {
      if (phone.isNotEmpty) {
        if (phone[0] == "0") {
          return "254${phone.substring(1)}";
        } else if (phone[0] == "+") {
          return phone.substring(1);
        } else {
          return phone;
        }
      } else {
        return "0000000000";
      }
    }

    newSingleSubmit();
    String dob = getBirth();
    try {
      final dynamic req = jsonEncode(
        //ensure that the user has bothe the socketID and the USER ID
        {
          "fname": fnController.text,
          "mname": mController.text,
          "lname": lnController.text,
          "idnumber": idController.text,
          "photourl": "https://google.com",
          "phone": zerototwo(phController.text),
          "password": passwordController.text,
          "email": "me@mailer.com",
          "fcmtoken": "FCMTOKENSAMPLE$accName",
          "informaladdress": "Machakos",
          "xcords": dob,
          "ycords": "0.0",
          "role": role
        },
      );
      final response = await post(
        Uri.parse(Constants.API_BASE + "treg"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: req,
      );
      var myjson = json.decode(response.body);
      if (myjson["status"] == 0) {
        isLoading = false;
        if (Platform.isAndroid) {
          FirebaseMessaging.instance.subscribeToTopic(myjson["topic"]);
        }
        notifyListeners();
        showCupertinoDialog(
          context: ctx,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );
      } else {
        isLoading = false;
        notifyListeners();
      }
    } catch (err) {
      isLoading = false;
      showCupertinoDialog(
        context: ctx,
        builder: (BuildContext context) => const ErrorPopUP(),
      );
    }
  }
}

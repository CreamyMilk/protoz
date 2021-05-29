import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:proto/constants.dart';
import 'package:proto/popups/errorPopup.dart';
import 'package:proto/popups/registrationPopup.dart';

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
  TextEditingController altPhoneNameController = TextEditingController();
  int activePage = 0;
  bool isLoading = false;

  String firstName;
  String middleName;
  String lastName;
  String day;
  String month;
  String year;
  String countrycode;
  String phoneNumber;
  String password;
  String role = "DEFAULT";
  bool terms = true;

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
    if (nameKey.currentState.validate()) {
      firstName = fnController.text;
      middleName = mnContorller.text;
      lastName = lnController.text;
      increment();
      //print("Text fiels Values are $t $d");
    }
  }

  void passwordFormSubmit() {
    if (passwordFormKey.currentState.validate()) {
      password = passwordController.text;
      increment();
    }
  }

  void idSubmit() {
    if (idKey.currentState.validate()) {
      year = yController.text;
      month = mController.text;
      day = dController.text;
      increment();
      //print("Text fiels Values are $t $d");
    }
  }

  void bfSubmit() {
    if (birthKey.currentState.validate()) {
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
    if (phoneKey.currentState.validate()) {
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

  Future zendPayment(BuildContext ctx) async {
    String accName = phoneNumber;
    isLoading = true;
    notifyListeners();
    Widget _buildPopupDialog(BuildContext context) {
      return RegistrationPopUp();
    }

    String zerototwo(String phone) {
      if (phone.length > 0) {
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

    String dob = getBirth();
    try {
      final response = await post(
        (Constants.API_BASE + "treg"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode(
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
            "fcmtoken": "FCMTOKENSAMPLE",
            "informaladdress": "Machakos",
            "xcords": "$dob",
            "ycords": "0.000010",
            "role": role
          },
        ),
      );
      print("$accName");
      var myjson = json.decode(response.body);
      if (myjson["status"] == 0) {
        isLoading = false;
        notifyListeners();
        showCupertinoDialog(
          context: ctx,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );
      } else {
        isLoading = false;
        notifyListeners();
        showCupertinoDialog(
          context: ctx,
          builder: (BuildContext context) => CannontReigsterPopUp(
            message: myjson["message"],
          ),
        );
      }
    } catch (SocketException) {
      isLoading = false;
      print("msEE HAUNA WIFI");
      showCupertinoDialog(
        context: ctx,
        builder: (BuildContext context) => ErrorPopUP(),
      );
    }
  }
}

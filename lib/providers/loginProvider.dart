import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:proto/popups/errorPopup.dart';
import 'package:proto/popups/registrationPopup.dart';

class LoginFormProvider extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  bool showError = false;
  bool loading = false;

  void attemptLogin(BuildContext ctx) {
    if (usernameController.text != "" && passwordController.text != "") {
      loading = true;
      showError = false;
      sendLoginRequest(ctx);
    
    } else {
      loading = false;
      showError = true;
    }
    notifyListeners();
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

  Future sendLoginRequest(BuildContext ctx) async {
    Widget _buildPopupDialog(BuildContext context) {
      return RegistrationPopUp();
    }

    try {
      final response = await post(
        ("http://192.168.0.13:3000/" + "login"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode(
          //ensure that the user has bothe the socketID and the USER ID
          {
            "phonenumber": zerototwo(usernameController.text),
            "password": passwordController.text
          },
        ),
      );
      var myjson = json.decode(response.body);
      if (myjson["status"] == 0) {
        showCupertinoDialog(
          context: ctx,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );
        Navigator.of(ctx).pushNamed("/home");
      } else {
        loading = false;
        usernameController.text = "";
        passwordController.text = "";
        notifyListeners();
        showCupertinoDialog(
          context: ctx,
          builder: (BuildContext context) => CannontReigsterPopUp(
            message: myjson["message"],
          ),
        );
      }
    } catch (SocketException) {
          loading = false;
        usernameController.text = "";
        passwordController.text = "";
        notifyListeners();
      showCupertinoDialog(
        context: ctx,
        builder: (BuildContext context) => ErrorPopUP(),
      );
    }
  }
}

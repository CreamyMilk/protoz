import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:proto/constants.dart';
import 'package:proto/popups/errorPopup.dart';

class LoginFormProvider extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  bool showError = false;
  bool loading = false;

  void attemptLogin(BuildContext ctx) async {
    if (usernameController.text != "" && passwordController.text != "") {
      loading = true;
      showError = false;
      notifyListeners();
      sendLoginRequest(ctx);
    } else {
      loading = false;
      showError = true;
      notifyListeners();
    }
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

  String getInitals(String l) {
    List<String> name = l.split(" ");
    if (name.length > 1) {
      return (name[0].substring(0, 1).toUpperCase() +
          name[name.length - 1].substring(0, 1).toUpperCase());
    } else {
      return name[0].substring(0, 1).toUpperCase();
    }
  }

  Future sendLoginRequest(BuildContext ctx) async {
    try {
      final response = await post(
        (Constants.API_BASE + "login"),
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
        var box = Hive.box(Constants.UserBoxName);
        String initals = getInitals(myjson["fullname"]);
        box.put(Constants.FullnameStore, myjson["fullname"]);
        box.put(Constants.InitalsStore, initals);
        box.put(Constants.PhoneNumberStore, myjson["phonenumber"]);
        box.put(Constants.WalletNameStore, myjson["walletname"]);
        box.put(Constants.BalanceStore, myjson["balance"]);
        box.put(Constants.RoleStore, myjson["role"]);
        box.put(Constants.UserIDStore, myjson["userid"]);
        box.put(Constants.NotifcationTopicStore, myjson["phonenumber"]);
        if (Platform.isAndroid) {
          FirebaseMessaging.instance.subscribeToTopic(myjson["walletname"]);
          FirebaseMessaging.instance.getToken().then((String token) {
            box.put(Constants.RawFCMTokenStore, token);
          });
        }
        box.put(Constants.IsLoggedInStore, true);
        Navigator.of(ctx).pushNamed("/home");
      } else {
        loading = false;
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
      notifyListeners();
    }
  }
}

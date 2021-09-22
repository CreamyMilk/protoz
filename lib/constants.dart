import 'package:hive/hive.dart';
import 'package:proto/utils/type_extensions.dart';

class Constants {
  static const String API_BASE = "http://35.189.74.247:3000/";
  static const String UserBoxName = "user";
  static const String IsLoggedInStore = "isloggedinbool";
  static const String UserTypeStore = "usertype";

  static const String FullnameStore = "name";
  static const String PhoneNumberStore = "phonenumber";
  static const String WalletNameStore = "walletname";
  static const String BalanceStore = "balance";
  static const String TotalOrdersStore = "totalorders";
  static const String OrdersListStore = "ordersList";
  static const String TransactionsStore = "transaction";
  static const String RoleStore = "role";
  static const String InitalsStore = "initals";
  static const String UserIDStore = "notimportantid";

  static const String RawFCMTokenStore = "rawfcmtoken";
  static const String NotifcationTopicStore = "notificationTopic";
  static const String AllUserNotifcationTopic = "all";

  static const String ReceiverNumberStore = "sendstore";
  static const String AmountToSendStore = "amountstore";

  static const String ProductCategoriesStore = "categoreieslist";

  static const String ChoosenCategory = "choosencategory";
  static const String PlaceHolderURl = "placeurl";

  static String zerototwo(String phone) {
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

  //Implement backend to do this
  static String getProductPlaceHolderURL() {
    Box box = Hive.box(UserBoxName);
    String placeHolderurl = box.get(PlaceHolderURl,
        defaultValue:
            "https://developersushant.files.wordpress.com/2015/02/no-image-available.png");
    return placeHolderurl;
  }

  static String getWalletID() {
    Box box = Hive.box(UserBoxName);
    String wid = box.get(WalletNameStore, defaultValue: "");
    if (wid == "") {
      print("You Need to login bro");
    }
    return wid;
  }

  static String getPhone() {
    Box box = Hive.box(UserBoxName);
    String phone = box.get(PhoneNumberStore, defaultValue: "");
    if (phone == "") {
      print("You have no stored phoneNumber meed to login bro");
    }
    return phone;
  }

  static bool hasStoredCreds() {
    Box box = Hive.box(UserBoxName);
    String wid = box.get(WalletNameStore, defaultValue: "");
    if (wid == "") {
      print("You dont have any store creds so login first");
      return false;
    }
    return true;
  }

  static String getWalletBalance() {
    Box box = Hive.box(UserBoxName);
    String balance = box.get(BalanceStore, defaultValue: "");
    if (balance == "") {
      print("You don't have any walletBalance");
      return "N/A";
    }
    return balance.addCommas;
  }

  //Must zero out all keys
  static Future<bool> logout() async {
    try {
      int clearINT = await Hive.box(UserBoxName).clear();
      print("[LOGOUT INT] $clearINT");
      return true;
    } catch (err) {
      print("[LOGOUT ERROR] $err");
      return false;
    }
  }
}

class Constants {
  static const String API_BASE = "http://34.125.117.7:3000/";
  static const String UserBoxName = "user";
  static const String IsLoggedInStore = "isloggedinbool";
  static const String UserTypeStore = "isloggedinbool";

  static const String FullnameStore = "name";
  static const String PhoneNumberStore = "phonenumber";
  static const String WalletNameStore = "walletname";
  static const String BalanceStore = "balance";
  static const String OrdersStore = "orders";
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

  static const String ChoosenCategory = "chossencategory";

  static String zerototwo(String phone) {
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
}

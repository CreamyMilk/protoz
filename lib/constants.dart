const String UserBoxName = "user";
const String IsLoggedInStore = "isloggedinbool";

const String FullnameStore = "name";
const String PhoneNumberStore = "phonenumber";
const String WalletNameStore = "walletname";
const String BalanceStore = "balance";
const String RoleStore = "role";
const String InitalsStore = "initals";

const String SenderNumberStore = "sendstore";
const String AmountToSendStore = "amountstore";

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

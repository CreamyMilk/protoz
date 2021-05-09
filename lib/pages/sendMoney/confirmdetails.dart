import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:proto/constants.dart';
import 'package:proto/utils/sizedMargins.dart';

class VerifyPaymentCard extends StatelessWidget {
  const VerifyPaymentCard({
    Key key,
    @required this.amount,
    @required this.receiverPhone,
    @required this.receiverName,
    @required this.fees,
  }) : super(key: key);

  final int amount;
  final String receiverPhone;
  final String receiverName;
  final int fees;

  @override
  Widget build(BuildContext context) {
    Box userBox;
    userBox = Hive.box(Constants.UserBoxName);
    int currentBalance = userBox.get(Constants.BalanceStore);
    return Card(
      elevation: 10,
      child: Container(
          padding: EdgeInsets.only(top: 10.0),
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Send",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "Ksh.${amount.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w300),
                      ),
                      //Text("0.00001 BTC"),
                      SizedBox(height: 30),
                      Text("To: $receiverPhone",
                          style: TextStyle(
                            color: Colors.grey,
                          )),

                      Row(children: [
                        Text(
                          "$receiverName",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300),
                        ),
                        Spacer(),
                        IconButton(
                            icon: Icon(Icons.edit_outlined,
                                color: Colors.black, size: 15),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ]),
                      SizedBox(height: 30),
                      Text(
                          "Fees: ${fees.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.0",
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
                //    IconButton(
                //                    icon: Icon(Icons.add, color: Colors.white),
                //                  onPressed: () {}),

                ExpansionTile(
                  onExpansionChanged: (bool currentState) {
                    print(currentState);
                  },
                  backgroundColor: Colors.white,
                  title: Text(
                    "DETAILS",
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                  children: <Widget>[
                    ListTile(
                        trailing: Text(
                            "Ksh.${currentBalance.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                            style: TextStyle(color: Colors.green)),
                        title: Text(
                          "Inital Balance",
                          style: TextStyle(color: Colors.black),
                        )),
                    ListTile(
                        trailing: Text(
                            "- Ksh.${(amount + fees).toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                            style: TextStyle(color: Colors.blue)),
                        title: Text(
                          "Transaction",
                          style: TextStyle(color: Colors.black),
                        )),
                    Divider(),
                    ListTile(
                        trailing: Text(
                            "Ksh.${((currentBalance) - (amount + fees)).toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                            style: TextStyle(color: Colors.green)),
                        title: Text(
                          "Final Balance",
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
              ])),
    );
  }
}

class ConfirmPage extends StatelessWidget {
  const ConfirmPage({
    Key key,
    @required this.amount,
    @required this.receiverPhone,
    @required this.receiverName,
    @required this.fees,
  }) : super(key: key);

  final int amount;
  final String receiverPhone;
  final String receiverName;
  final int fees;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedContainer(
        duration: Duration(seconds: 1),
        height: 50,
        width: screenWidth(context, percent: 0.8),
        decoration: BoxDecoration(
          color: Colors.greenAccent[400],
          boxShadow: [
            BoxShadow(
                color: Colors.grey[400].withOpacity(0.3),
                offset: Offset(0, 13),
                blurRadius: 30)
          ],
        ),
        // ignore: deprecated_member_use
        child: FlatButton(
          onPressed: () async {
            Navigator.of(context).pushNamed("/pin");
          },
          color: Colors.transparent,
          child: Text(
            "Continue   ->",
            style: GoogleFonts.nunito(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: Center(
        child: LongPressDraggable(
            childWhenDragging: Container(),
            feedback: VerifyPaymentCard(
                amount: (amount),
                fees: fees,
                receiverPhone: receiverPhone,
                receiverName: receiverName),
            child: VerifyPaymentCard(
                amount: (amount),
                fees: fees,
                receiverPhone: receiverPhone,
                receiverName: receiverName)),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BuySellPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed("/buyer");
              },
              child: ButtonBigi(
                buttonText: "Buy",
          
              ),
            ),
            ButtonBigi(
              buttonText: "Sell",
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                          minWidth: MediaQuery.of(context).size.width * 0.3,
                  height: 100,
                  color: Colors.yellow,
                  onPressed: () {
                    Navigator.of(context).pushNamed("/");
                  },
                  child: Text("Balance"),
                ),
               MaterialButton(
                          minWidth: MediaQuery.of(context).size.width * 0.3,
                  height: 100,
                  color: Colors.yellow,
                  onPressed: () {},
                  child: Text("LOAN"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ButtonBigi extends StatelessWidget {
  final String buttonText;

  const ButtonBigi({Key key, @required this.buttonText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(70),
      ),
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 300,
      width: 400,
      child: Center(
        child: InkWell(
          focusColor: Colors.cyan,
          borderRadius: BorderRadius.circular(70),
          splashColor: Colors.red,
          onTap: () {},
          child: Text(
          buttonText,
          style: TextStyle(fontSize: 80),
        ),
        ),
      ),
    );
  }
}

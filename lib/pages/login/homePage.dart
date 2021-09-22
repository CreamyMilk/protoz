import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proto/utils/sizedMargins.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "AGRO ",
                  style: GoogleFonts.nunito(
                      color: Colors.tealAccent[400],
                      fontSize: 30,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  "| Crm",
                  style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 30,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: screenWidth(context, percent: 0.4),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[400]!.withOpacity(0.5),
                          offset: Offset(0, 13),
                          blurRadius: 30)
                    ],
                  ),
                  child: MaterialButton(
                    color: Colors.tealAccent[400],
                    onPressed: () {
                      Navigator.of(context).pushNamed("/login");
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const XMargin(20),
                Container(
                  height: 50,
                  width: screenWidth(context, percent: 0.4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[400]!.withOpacity(0.3),
                          offset: Offset(0, 13),
                          blurRadius: 30)
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/kraform");
                    },
                    color: Colors.white,
                    child: Text(
                      "New Registration",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          color: Colors.greenAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
            const YMargin(50)
          ],
        ),
      ),
    );
  }
}

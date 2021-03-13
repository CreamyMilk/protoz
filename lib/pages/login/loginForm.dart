import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proto/utils/sizedMargins.dart';

class LoginFormPage extends StatefulWidget {
  LoginFormPage({Key key}) : super(key: key);

  @override
  _LoginFormPageState createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
            appBar:AppBar(
              backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon:Icon(Icons.arrow_back,size:20,color: Colors.grey,),onPressed: (){
          Navigator.of(context).pop();
        },)
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              height: screenHeight(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Agro ",
                        style: GoogleFonts.nunito(
                            color: Colors.tealAccent[400],
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "| Login",
                        style: GoogleFonts.lato(
                            color: Colors.grey,
                            fontSize: 30,
                            fontWeight: FontWeight.w300),
                      ),
                   ],
                  ),
                  const YMargin(50),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400].withOpacity(0.1),
                            offset: Offset(0, 13),
                            blurRadius: 30)
                      ],
                    ),
                    child: Container(
                      width: screenWidth(context, percent: 0.8),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Phone Number',
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[300],
                            ),
                          ),
                          //controller: provider.ip,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                          keyboardAppearance: Brightness.light,
                          autofocus: false),
                    ),
                  ),

                  const YMargin(30),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400].withOpacity(0.1),
                            offset: Offset(0, 13),
                            blurRadius: 30)
                      ],
                    ),
                    child: Container(
                      width: screenWidth(context, percent: 0.8),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Password',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[300],
                            ),
                          ),
                          //controller: provider.name,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                          keyboardAppearance: Brightness.light,
                          autofocus: false),
                    ),
                  ),
                  const YMargin(30),
                  Container(
                    width: screenWidth(context, percent: 0.8),
                    child: Row(
                      children: <Widget>[
                        Text(
                        "  provider?.errorMessage ?? ''",
                          style: GoogleFonts.nunito(
                              color: Colors.redAccent,
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 45,
                        width: screenWidth(context, percent: 0.8),
                        decoration: BoxDecoration(
                          color: Colors.tealAccent[400],
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[400].withOpacity(0.5),
                                offset: Offset(0, 13),
                                blurRadius: 30)
                          ],
                        ),
                        // ignore: deprecated_member_use
                        child: MaterialButton(
                          elevation: 0,
                          onPressed: () {
                            //provider.startLoginFormPager(context);
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const YMargin(150)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

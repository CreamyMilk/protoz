import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proto/providers/login_provider.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:provider/provider.dart';

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({Key? key}) : super(key: key);

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
    final hbox = Provider.of<LoginFormProvider>(context);
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: hbox.loginFormKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: screenHeight(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Spacer(),
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
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[600]!.withOpacity(0.3),
                              offset: const Offset(0, 13),
                              blurRadius: 30)
                        ],
                      ),
                      child: Container(
                        width: screenWidth(context, percent: 0.8),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                            controller: hbox.usernameController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Phone Number',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[500],
                              ),
                            ),
                            //controller: provider.ip,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                            ),
                            keyboardAppearance: Brightness.light,
                            autofocus: false),
                      ),
                    ),
                    const YMargin(30),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[600]!.withOpacity(0.3),
                              offset: const Offset(0, 13),
                              blurRadius: 50)
                        ],
                      ),
                      child: Container(
                        width: screenWidth(context, percent: 0.8),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                            controller: hbox.passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[500],
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
                    SizedBox(
                      width: screenWidth(context, percent: 0.8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            hbox.showError ? "  sample errorMessage " : "",
                            style: GoogleFonts.nunito(
                                color: Colors.redAccent,
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        hbox.loading
                            ? const CircularProgressIndicator()
                            : Container(
                                height: 50,
                                width: screenWidth(context, percent: 0.8),
                                decoration: BoxDecoration(
                                  color: Colors.tealAccent[400],
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Colors.grey[400]!.withOpacity(0.5),
                                        offset: const Offset(0, 13),
                                        blurRadius: 30)
                                  ],
                                ),
                                child: MaterialButton(
                                  elevation: 0,
                                  onPressed: () {
                                    hbox.attemptLogin(context);
                                    //Navigator.of(context).pushNamed("/home");
                                    //provider.startLoginFormPager(context);
                                  },
                                  child: Text(
                                    "Submit",
                                    style: GoogleFonts.nunito(
                                        color: Colors.white,
                                        fontSize: 15,
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
      ),
    );
  }
}

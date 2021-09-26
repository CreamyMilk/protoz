import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proto/utils/sizedMargins.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<DropdownMenuItem<String>> temp = [];
  List<String> options = [
    "Farmer",
    "Agro input supplier",
    "Farm Products Consumer",
    "Logistics",
    "Market Information",
    "Consultany Services"
  ];
  late String _role;
  late bool terms;
  @override
  void initState() {
    for (var t in options) {
      temp.add(DropdownMenuItem<String>(
        value: t,
        child: Text(t),
      ));
    }
    super.initState();
    terms = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(),
        elevation: 0,
        backgroundColor: Colors.tealAccent[400],
        onPressed: () {
          Navigator.of(context).pushNamed("/home");
        },
        label: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Complete Registration",
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.tealAccent[400],
        title: Text("Create Account"),
      ),
      body: Column(
        children: [
          // Text("Kindly Fill in your information below",
          //     style: const TextStyle(
          //         fontWeight: FontWeight.w500,
          //         fontSize: 20,
          //         color: Colors.teal[400])),
          // SizedBox(height: 40),
          const YMargin(30),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400]!.withOpacity(0.1),
                    offset: Offset(0, 13),
                    blurRadius: 30)
              ],
            ),
            child: Container(
              width: screenWidth(context, percent: 0.9),
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
          YMargin(30),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400]!.withOpacity(0.1),
                    offset: Offset(0, 13),
                    blurRadius: 30)
              ],
            ),
            child: Container(
              width: screenWidth(context, percent: 0.9),
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Id Number',
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
                    color: Colors.grey[400]!.withOpacity(0.1),
                    offset: Offset(0, 13),
                    blurRadius: 30)
              ],
            ),
            child: Container(
              width: screenWidth(context, percent: 0.9),
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
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
                    color: Colors.grey[400]!.withOpacity(0.1),
                    offset: Offset(0, 13),
                    blurRadius: 30)
              ],
            ),
            child: Container(
              width: screenWidth(context, percent: 0.9),
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Residense',
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
                    color: Colors.grey[400]!.withOpacity(0.1),
                    offset: Offset(0, 13),
                    blurRadius: 30)
              ],
            ),
            child: Container(
              width: screenWidth(context, percent: 0.9),
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Address',
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
          const YMargin(20),

          SizedBox(
            width: screenWidth(context, percent: 0.9),
            // padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400]!.withOpacity(0.1),
                            offset: Offset(0, 13),
                            blurRadius: 30)
                      ],
                    ),
                    child: Container(
                      // width: screenWidth(context, percent: 0.2),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Role",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400]!.withOpacity(0.1),
                            offset: Offset(0, 13),
                            blurRadius: 30)
                      ],
                    ),
                    child: Container(
                      width: screenWidth(context, percent: 0.70),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: DropdownButtonFormField(
                        elevation: 1,
                        items: temp,
                        value: _role,
                        onChanged: (String? value) {
                          setState(() {
                            _role = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const YMargin(5),
                ]),
          ),
          const YMargin(30),
          SizedBox(
              width: screenWidth(context, percent: 0.85),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                      activeColor: Colors.tealAccent[400],
                      value: terms,
                      onChanged: (v) {
                        setState(() {
                          terms = !terms;
                        });
                      }),
                  Text(
                    "I Agree to the provided Terms and Conditions",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w100),
                  )
                ],
              )),
          Spacer(),

          const YMargin(100),
        ],
      ),
    );
  }
}

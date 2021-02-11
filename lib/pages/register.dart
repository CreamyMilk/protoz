import 'package:flutter/material.dart';

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
  String _role;
  bool terms;
  @override
  void initState() {
    options.forEach((t) {
      temp.add(DropdownMenuItem<String>(
        value: t,
        child: Text(t),
      ));
    });
    super.initState();
    terms = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 30),
          Text("Double-check your information just to be sure",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.teal[400])),
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return "Required";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                labelText: 'First Name',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return "Required";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                focusColor: Colors.teal,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
                labelText: 'Last Name',
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 5),
                  Flexible(
                    flex: 2,
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Country',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                      ),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: 25),
                  Flexible(
                    flex: 10,
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter Phone number',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                      ),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: 5),
                ]),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return "Required";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                focusColor: Colors.teal,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
                labelText: 'Residence',
              ),
              maxLines: 1,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 5),
                  Flexible(
                    flex: 2,
                    child: Text("Role"),
                  ),
                  SizedBox(width: 25),
                  Flexible(
                    flex: 10,
                    child: DropdownButtonFormField(
                      items: temp,
                      value: _role,
                      onChanged: (String value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                ]),
          ),
          SizedBox(height: 30),
          Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                      activeColor: Colors.teal,
                      value: terms,
                      onChanged: (v) {
                        setState(() {
                          terms = !terms;
                        });
                      }),
                  Text("By proceeding you agree to our Terms and Conditions")
                ],
              )),
          Spacer(),
          MaterialButton(onPressed: () {
            Navigator.of(context).pushNamed("/login");
          }),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

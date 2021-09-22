import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
                tag: "logo",
                child: Icon(
                  Icons.filter_drama,
                  size: 50,
                )),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: const [
                      TextSpan(
                          text: "WELCOME TO\n",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 30.0)),
                      TextSpan(
                          text: "AGRO CRM",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 25.0)),
                    ])),
                SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  color: Colors.yellow,
                  child: Text(
                    "Login as member",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/home');
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  color: Colors.grey[350],
                  child: Text(
                    "Register as member",
                    style: TextStyle(color: Colors.grey[900]),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:proto/models/paymentResponseModel.dart';
import 'package:proto/popups/errorPopup.dart';
import 'package:proto/popups/registrationPopup.dart';
import 'package:proto/providers/stepperFormProvider.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:provider/provider.dart';

class BaseForm extends StatefulWidget {
  BaseForm({Key key}) : super(key: key);

  @override
  _BaseFormState createState() => _BaseFormState();
}

class _BaseFormState extends State<BaseForm> {
  List<Widget> pages = [
    NameForm(),
    BirthForm(),
    NumberForm(),
    IdentificationForm(),
    PasswordForm(),
    RoleForm(),
    DoubleCheckPage(),
  ];

  int activePage;

  @override
  Widget build(BuildContext context) {
    final hbox = Provider.of<KraFormProvider>(context);
    final activePage = hbox.activePage;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: activePage == 0 ? Icon(Icons.home) : Icon(Icons.arrow_back),
              onPressed: () {
                if (activePage != 0) {
                  hbox.decrement();
                } else {
                  Navigator.of(context).pop();
                }
              }),
          backgroundColor: Colors.teal[400],
          title: Transform.translate(
              offset: Offset(30, 0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: LinearProgressIndicator(
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                      backgroundColor: Colors.teal[600],
                      value: (1/7) * (activePage + 1))))),
      body: pages[activePage],
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor:Colors.lightGreen,
      //   onPressed: () {
      //     if (activePage == 0) {
      //       hbox.nfSubmit();
      //     } else if (activePage == 1) {
      //       hbox.bfSubmit();
      //     } else if (activePage == 2) {
      //       hbox.phSubmit();
      //     } else if (activePage == 3) {
      //       hbox.krSubmit();
      //     } else {
      //       if (activePage != pages.length - 1) {
      //         hbox.increment();
      //         print("okokok");
      //       }
      //     }
      //   },
      //   icon: activePage == pages.length - 1
      //       ? Icon(Icons.check_circle_outline, color: Colors.white)
      //       : null,
      //   label: Text(
      //       (activePage != pages.length - 1
      //           ? "      NEXT       "
      //           : "      Pay Now       "),
      //       style: TextStyle(color: Colors.white, fontSize: 15)),
      // ),
    );
  }
}

class NameForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hbox = Provider.of<KraFormProvider>(context);
    return Form(
      key: hbox.nameKey,
      child: Column(
        children: [
          const YMargin(30),
          Text("Lets Register you to the AgroCrm",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.teal[400])),
          const YMargin(15),
          Text("Whats is your name ?",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          const YMargin(15),
          Text("Just as it appears on your National ID",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const YMargin(50),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              controller: hbox.fnController,
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
          const YMargin(10),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              controller: hbox.mnContorller,
              validator: (value) {
                if (value.isEmpty) {
                  return "Required";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                labelText: 'Middle Name',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
              ),
              maxLines: 1,
            ),
          ),
          const YMargin(10),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              controller: hbox.lnController,
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
          Spacer(),
          ButtonBasis(
            buttonFuntion: () {
              hbox.nfSubmit();
            },
          ),
        ],
      ),
    );
  }
}

class BirthForm extends StatelessWidget {
  const BirthForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hbox = Provider.of<KraFormProvider>(context);
    // Show the modal that contains the CupertinoDatePicker
    void _showDatePicker(ctx) {
      // showCupertinoModalPopup is a built-in function of the cupertino library
      showCupertinoModalPopup(
          context: ctx,
          builder: (_) => Container(
                height: screenHeight(context, percent: 0.36),
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (val) {
                            hbox.yController.text = "${val.year}";
                            hbox.mController.text = "${val.month}";
                            hbox.dController.text = "${val.day}";
                          }),
                    ),
                    // Close the modal
                    CupertinoButton(
                      child: Text('OK'),
                      onPressed: () => Navigator.of(ctx).pop(),
                    )
                  ],
                ),
              ));
    }
    return Form(
      key: hbox.birthKey,
      child: Column(children: [
        SizedBox(height: 30),
        Text("Whats is your date of birth?",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
        SizedBox(height: 15),
        Text("Just as it appears on your National ID",
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        SizedBox(height: 50),
        CupertinoButton(
          child: Text("From Calender"),
          onPressed: () => _showDatePicker(context),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(width: 5),
            Flexible(
              child: TextFormField(
                controller: hbox.yController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Year',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                ),
                maxLines: 1,
              ),
            ),
            SizedBox(width: 25),
            Flexible(
              child: TextFormField(
                controller: hbox.mController,
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Month',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                ),
                maxLines: 1,
              ),
            ),
            SizedBox(width: 25),
            Flexible(
              child: TextFormField(
                controller: hbox.dController,
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Day',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                ),
                maxLines: 1,
              ),
            ),
          ]),
        ),
        Spacer(),
        ButtonBasis(
          buttonFuntion: () {
            hbox.bfSubmit();
          },
        ),
      ]),
    );
  }
}

class NumberForm extends StatelessWidget {
  const NumberForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fstore = Provider.of<KraFormProvider>(context);
    fstore.cnController.text = "+254";
    final name = fstore.firstName;
    return Form(
      key: fstore.phoneKey,
      child: Column(
        children: [
          SizedBox(height: 30),
          Text("Ok $name !",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.teal[400])),
          SizedBox(height: 15),
          Text("Whats is your Phone Number ?",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          SizedBox(height: 15),
          Text("Recommeded to use Safaricom number",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 5),
                Flexible(
                  flex: 2,
                  child: TextFormField(
                    maxLength: 4,
                    controller: fstore.cnController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      counterText: "",
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
                    maxLength: 10,
                    controller: fstore.phController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      counterText: "",
                      labelText: 'Enter Phone number',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
          Spacer(),
          ButtonBasis(
            buttonFuntion: () {
              fstore.phSubmit();
            },
          ),
        ],
      ),
    );
  }
}

class IdentificationForm extends StatelessWidget {
  const IdentificationForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fstore = Provider.of<KraFormProvider>(context);

    final name = fstore.firstName;
    return Form(
      key: fstore.idKey,
      child: Column(
        children: [
          SizedBox(height: 30),
          Text("Ok $name !",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.teal[400])),
          SizedBox(height: 15),
          Text("Whats is your Identification Card Number ?",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          SizedBox(height: 15),
          Text("",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          SizedBox(height: 50),
                   Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              controller: fstore.idController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Required";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                labelText: 'ID Number',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
              ),
              maxLines: 1,
            ),
          ),
          Spacer(),
          ButtonBasis(
            buttonFuntion: () {
              fstore.idSubmit();
            },
          ),
        ],
      ),
    );
  }
}

class PasswordForm extends StatelessWidget {
  const PasswordForm({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final hbox = Provider.of<KraFormProvider>(context);
    return Form(
      key: hbox.passwordFormKey,
      child: Column(
        children: [
          const YMargin(30),
          Text("Secure your AgroCrm account",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.teal[400])),
          const YMargin(15),
          Text("Kndly Enter your preferd password ?",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          const YMargin(15),
          Text("Don't share your password with any one",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const YMargin(50),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              obscureText: true,
              controller: hbox.passwordController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Required";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                labelText: 'Passowrd',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
              ),
              maxLines: 1,
            ),
          ),
       
          const YMargin(10),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              obscureText: true,
              controller: hbox.clonePasswordController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Required";
                }else if(value != hbox.passwordController.text){
                  return "Password do not match";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                focusColor: Colors.teal,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
                labelText: 'Confirm Password',
              ),
              maxLines: 1,
            ),
          ),
          Spacer(),
          ButtonBasis(
            buttonFuntion: () {
              hbox.passwordFormSubmit();
            },
          ),
        ],
      ),
    );
  }
}

class RoleForm extends StatefulWidget {
const RoleForm({Key key}) : super(key: key);

  @override
  _RoleFormState createState() => _RoleFormState();
}

class _RoleFormState extends State<RoleForm> {
  List<DropdownMenuItem<String>> temp = [];
  List<String> options = [
    "Farmer ",
    "Agro input supplier",
    "Farm Products Consumer",
    "Logistics",
    "Market Information",
    "Consultany Services"
  ];
  String _role;

  @override
  void initState() {
    options.forEach((t) {
      temp.add(DropdownMenuItem<String>(
        value: t,
        child: Text(t),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fstore = Provider.of<KraFormProvider>(context);
    return Form(
      key: fstore.kraKey,
      child: Column(children: [
        SizedBox(height: 30),
        Text("Almost there!",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.teal[400])),
        SizedBox(height: 5),
        Text("Final personal check",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 19,
                color: Colors.teal[400])),
        SizedBox(height: 15),
        Text("Kindly choose the role you are registering for",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
        SizedBox(height: 15),
        Text("Select One", style: TextStyle(fontSize: 12, color: Colors.grey)),
        SizedBox(height: 50),
        Container(
          padding: EdgeInsets.only(left: 60, right: 60),
          child: Container(
            width: screenWidth(context, percent: 0.70),
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: DropdownButtonFormField(
              elevation: 1,
              items: temp,
              value: _role,
              onChanged: (String value) {
                fstore.krapin = value;
                setState(() {
                  _role = value;
                });
              },
            ),
          ),
        ),
        Spacer(),
        ButtonBasis(
          buttonFuntion: () {
            fstore.krSubmit();
          },
        ),
      ]),
    );
  }
}

class DoubleCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fstore = Provider.of<KraFormProvider>(context);
    return ListView(
       padding: EdgeInsets.only(left:8.0,right:10.0),
     shrinkWrap: true,
      children: [
      SizedBox(height: 30),
      Text("Double-check your information just to be sure",
      textAlign: TextAlign.center,
    style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color: Colors.teal[400])),
      SizedBox(height: 40),
      Container(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: TextFormField(
    initialValue: fstore.firstName,
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
    initialValue: fstore.middleName,
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
      labelText: 'Middle Name',
    ),
    maxLines: 1,
        ),
      ),
      SizedBox(height: 10),
      Container(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: TextFormField(
    initialValue: fstore.lastName,
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
        child:
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    SizedBox(width: 5),
    Flexible(
      flex: 2,
      child: TextFormField(
        initialValue: fstore.countrycode,
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
        controller: fstore.phController,
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


            Container(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: TextFormField(
    initialValue: fstore.middleName,
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
      labelText: 'ID Number',
    ),
    maxLines: 1,
        ),
      ),
      SizedBox(height: 10),
      Container(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: TextFormField(
    initialValue: fstore.krapin,
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
      labelText: 'ROLE',
    ),
    maxLines: 1,
        ),
      ),
      SizedBox(height: 50),
      Container(
    padding: EdgeInsets.only(right: 10.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
            activeColor: Colors.teal,
            value: true,
            onChanged: (v) {
              fstore.termsAccept(v);
            }),
        Text("By proceeding you agree to our Terms and Conditions")
      ],
    )),
      Spacer(),
      ButtonBasis(
        isLastPage: true,
        buttonFuntion: () {
    fstore.finalSubmit();
    zendPayment(fstore.phoneNumber, "100", fstore.phoneNumber, context);
        },
      ),
      ],
        );
  }
}

Future zendPayment(
    String mobile, String amountDue, String accName, BuildContext ctx) async {
  Widget _buildPopupDialog(BuildContext context) {
    return RegistrationPopUp();
  }

  PaymentResponse data;
  try {
    String fcmToken = "no";
    final response = await post(
      ("https://googlesecureotp.herokuapp.com/" + "payment"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        //ensure that the user has bothe the socketID and the USER ID
        {
          "phonenumber": mobile,
          "amount": amountDue,
          "userID": accName ?? "Error",
          "socketID": "mee",
          "notifToken": fcmToken
        },
      ),
    );
    print("$accName");
    var myjson = json.decode(response.body);
    print(fcmToken);
    data = PaymentResponse.fromJson(myjson);
    print(data.paymentCode);
    if (data.description == "0") {
      showCupertinoDialog(
        context: ctx,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    }
  } catch (SocketException) {
    print("msEE HAUNA WIFI");
    showCupertinoDialog(
      context: ctx,
      builder: (BuildContext context) => ErrorPopUP(),
    );
  }
}

class ButtonBasis extends StatelessWidget {
  final void Function() buttonFuntion;
  final bool isLastPage;
  const ButtonBasis({
    Key key,
    this.isLastPage: false,
    @required this.buttonFuntion,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 45,
              width: isLastPage
                  ? screenWidth(context, percent: 0.5)
                  : screenWidth(context, percent: 0.35),
              decoration: BoxDecoration(
                color: isLastPage ? Colors.tealAccent[400] : Colors.lightGreen,
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
                onPressed: buttonFuntion,
                child: Text(
                  isLastPage ? "Pay Now" : "Next",
                  style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
        const YMargin(10)
      ],
    );
  }
}

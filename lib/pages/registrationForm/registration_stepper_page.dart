import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proto/constants.dart';
import 'package:proto/main.dart';
import 'package:proto/popups/error_popup.dart';
import 'package:proto/popups/registration_popup.dart';
import 'package:proto/utils/sized_margins.dart';
import 'package:proto/widgets/image_selector.dart';

class RegistrationStepperForm extends StatefulWidget {
  const RegistrationStepperForm({Key? key}) : super(key: key);

  @override
  _RegistrationStepperFormState createState() =>
      _RegistrationStepperFormState();
}

class _RegistrationStepperFormState extends State<RegistrationStepperForm> {
  List<bool> stages = [false, false, true, false, false];

  String profileimgUrl = "";
  String dateOfBirth = "";
  String phoneNumber = "";
  String storeName = "";
  String idimgUrl = "";
  String idNumber = "";
  String fullName = "";
  String email = "";
  String cpin = "";
  String pin = "";

  bool idLoading = false;
  bool profileLoading = false;
  bool showFab = false;

  List<DropdownMenuItem<String?>> temp = [];
  List<String> options = [
    "Farmer",
    "Logistics",
    "Agro Input Supplier",
  ];

  String? _role;
  TextEditingController dobController = TextEditingController();
  int _currentStep = 0;
  String datetxt = "";
  StepperType stepperType = StepperType.vertical;
  _pickDOB(BuildContext ctx) async {
    DateTime? pickedDate = await showDatePicker(
        initialDatePickerMode: DatePickerMode.year,
        context: ctx,
        initialDate: DateTime(1990),
        firstDate: DateTime(1900),
        fieldLabelText: "Date of birth",
        lastDate: DateTime.now());
    if (pickedDate != null) {
      dobController.text = DateFormat('yMMMMd').format(pickedDate);
      _personalDetails();
    }
    _personalDetails();
  }

  _personalDetails() {
    if (fullName != "" &&
        storeName != "" &&
        idNumber != "" &&
        dobController.text != "") {
      setState(() {
        stages[0] = true;
      });
    }
  }

  _contactDetails() {
    if (phoneNumber != "" && email != "") {
      setState(() {
        stages[1] = true;
      });
    }
  }

  _pinDetails() {
    if (pin != "" && cpin != "" && pin == cpin) {
      setState(() {
        stages[3] = true;
      });
    }
  }

  @override
  void initState() {
    _role = null;
    for (String? t in options) {
      temp.add(DropdownMenuItem<String?>(
        value: t,
        child: Text(t!),
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registration Page'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Stepper(
                type: StepperType.vertical,
                physics: const ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                controlsBuilder: controlz,
                steps: <Step>[
                  Step(
                    title: const Text('Personal Details'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const YMargin(10),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                          ),
                          onChanged: (String value) {
                            _personalDetails();
                            setState(() {
                              fullName = value;
                            });
                          },
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Store Name',
                          ),
                          onChanged: (String value) {
                            _personalDetails();
                            setState(() {
                              storeName = value;
                            });
                          },
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (String p) {
                            _pickDOB(context);
                          },
                          decoration:
                              const InputDecoration(labelText: 'ID Number'),
                          onChanged: (String value) {
                            _personalDetails();
                            setState(() {
                              idNumber = value;
                            });
                          },
                        ),
                        const YMargin(10),
                        TextFormField(
                          onChanged: (String value) {
                            _personalDetails();
                          },
                          controller: dobController,
                          decoration:
                              const InputDecoration(labelText: 'Date Of Birth'),
                          onTap: () {
                            _pickDOB(context);
                          },
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text('Contact Details'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          maxLength: 10,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false, signed: false),
                          decoration:
                              const InputDecoration(labelText: 'Mpesa Number'),
                          onChanged: (String value) {
                            _contactDetails();
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          onChanged: (String value) {
                            _contactDetails();
                            setState(() {
                              email = value;
                            });
                          },
                          decoration:
                              const InputDecoration(labelText: 'Email Address'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text('Photos'),
                    content: Row(
                      children: <Widget>[
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                File? f = await pickImg();
                                if (f != null) {
                                  setState(() {
                                    idLoading = true;
                                  });
                                  String? url = await uploadProductImage(f);
                                  if (url != null) {
                                    setState(() {
                                      idLoading = false;
                                      idimgUrl = url;
                                    });
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  transformAlignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                  ),
                                  height: 105,
                                  width: 105,
                                  child: idimgUrl == ""
                                      ? idLoading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : const Icon(Icons.camera_rounded,
                                              color: Colors.black)
                                      : Image.network(idimgUrl,
                                          fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            const Text("ID Photo")
                          ],
                        ),
                        const XMargin(10),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                File? f = await pickImg();
                                if (f != null) {
                                  setState(() {
                                    profileLoading = true;
                                  });
                                  String? url = await uploadProductImage(f);
                                  if (url != null) {
                                    //Append to images if their is an array of images later
                                    setState(() {
                                      profileLoading = false;
                                      profileimgUrl = url;
                                    });
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  transformAlignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                  ),
                                  height: 105,
                                  width: 105,
                                  child: profileimgUrl == ""
                                      ? profileLoading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : const Icon(Icons.person,
                                              color: Colors.black)
                                      : Image.network(profileimgUrl,
                                          fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            const Text("Profile Photo")
                          ],
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text('Security'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          maxLength: 4,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration:
                              const InputDecoration(labelText: 'Account Pin'),
                          onChanged: (String value) {
                            setState(() {
                              _pinDetails();
                              pin = value;
                            });
                          },
                        ),
                        TextFormField(
                          maxLength: 4,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                          decoration:
                              const InputDecoration(labelText: 'Confirm Pin'),
                          onChanged: (String value) {
                            _pinDetails();
                            setState(() {
                              cpin = value;
                            });
                          },
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 3
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text('Role and Payment'),
                    content: Column(
                      children: <Widget>[
                        const YMargin(10),
                        SizedBox(
                          width: screenWidth(context, percent: 0.70),
                          child: DropdownButtonFormField<String?>(
                            decoration: const InputDecoration(
                              labelText: "Pick Role",
                              hintText: "Select One",
                              border: OutlineInputBorder(),
                            ),
                            elevation: 1,
                            items: temp,
                            hint: const Text("PIck One Role"),
                            value: _role,
                            onChanged: (String? value) {
                              if (value != null) {
                                setState(() {
                                  _role = value;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 4
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: _role != null
            ? FloatingActionButton.extended(
                elevation: 0,
                icon: const Icon(Icons.arrow_forward),
                onPressed: _handleRegistrationSubmittion,
                label: const Text("Pay Now"),
              )
            : null);
  }

  Future _handleRegistrationSubmittion() async {
    try {
      final response = await post(
        Uri.parse(Constants.API_BASE + "auth/register"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode(
          {
            "fullname": fullName,
            "storename": storeName,
            "idnumber": idNumber,
            "dateofbirth": dobController.text,
            "phone": phoneNumber,
            "email": email,
            "profile": profileimgUrl,
            "idphoto": idimgUrl,
            "pin": pin,
            "role": _role,
            "fcmtoken": "",
            "informaladdress": "",
            "xcords": "",
            "ycords": ""
          },
        ),
      );
      var myjson = json.decode(response.body);
      if (myjson["status"] == 0) {
        if (Platform.isAndroid) {
          FirebaseMessaging.instance.subscribeToTopic(myjson["topic"]);
        }
        showCupertinoDialog(
          context: navigatorKey.currentContext!,
          builder: (BuildContext context) => const RegistrationPopUp(),
        );
      } else {
        showCupertinoDialog(
          context: navigatorKey.currentContext!,
          builder: (BuildContext context) => CustomErrorPopup(
            message: myjson["message"],
          ),
        );
      }
    } catch (err) {
      // ignore: avoid_print
      print(err);
    }
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  Widget controlz(BuildContext context,
      {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
    return Column(
      children: [
        const YMargin(30),
        Row(
          children: <Widget>[
            OutlinedButton(
              onPressed: cancel,
              child: const Text('Back',
                  style: TextStyle(
                    color: Colors.red,
                  )),
            ),
            const Spacer(),
            stages[_currentStep]
                //_currentStep != 4
                ? OutlinedButton(
                    onPressed: continued,
                    child: const Text('Continue'),
                  )
                : const YMargin(1),
          ],
        ),
      ],
    );
  }

  continued() {
    _currentStep < 4 ? setState(() => _currentStep += 1) : null;
    if (_currentStep == 4) {
      setState(() {
        showFab = true;
      });
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}

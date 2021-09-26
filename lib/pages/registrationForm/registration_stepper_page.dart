import 'package:flutter/material.dart';
import 'package:proto/utils/sizedMargins.dart';

class RegistrationStepperForm extends StatefulWidget {
  const RegistrationStepperForm({Key? key}) : super(key: key);

  @override
  _RegistrationStepperFormState createState() =>
      _RegistrationStepperFormState();
}

class _RegistrationStepperFormState extends State<RegistrationStepperForm> {
  List<DropdownMenuItem<String>> temp = [];
  List<String> options = [
    "",
    "Farmer ",
    "Agro input supplier",
    "Logistics",
    "Aggregators",
    "Machinery",
    "Market Information",
    "Advisory Services"
  ];

  late String _role;
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
      setState(() {
        datetxt = pickedDate.toIso8601String();
      });
    }
  }

  @override
  void initState() {
    _role = "";
    for (String t in options) {
      temp.add(DropdownMenuItem<String>(
        value: t,
        child: Text(t),
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
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Full Name'),
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Store Name'),
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'ID Number'),
                      ),
                      const YMargin(10),
                      const YMargin(10),
                      MaterialButton(
                        elevation: 0,
                        color: Colors.green[100],
                        child: Text(datetxt == ""
                            ? "Choose Date of Birth"
                            : "DOB :$datetxt"),
                        onPressed: () => _pickDOB(context),
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
                        decoration:
                            const InputDecoration(labelText: 'Phone Number'),
                      ),
                      TextFormField(
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
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'ID Photo'),
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Profile Photo'),
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
                        decoration:
                            const InputDecoration(labelText: 'Account Pin'),
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Confirm Pin'),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Role and Payment'),
                  content: Column(
                    children: <Widget>[
                      SizedBox(
                        width: screenWidth(context, percent: 0.80),
                        child: DropdownButtonFormField(
                          elevation: 1,
                          items: temp,
                          hint: const Text("Select One Role"),
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
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Mpesa PhoneNumber'),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.arrow_forward),
        onPressed: () {
          print("ehllo");
        },
        label: const Text("Complete Registration"),
      ),
    );
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
                  style: const TextStyle(
                    color: Colors.red,
                  )),
            ),
            Spacer(),
            OutlinedButton(
              onPressed: continued,
              child: const Text('Continue'),
            ),
          ],
        ),
      ],
    );
  }

  continued() {
    _currentStep < 4 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}

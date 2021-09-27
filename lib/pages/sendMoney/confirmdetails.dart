import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:proto/constants.dart';
import 'package:proto/utils/sizedMargins.dart';

class VerifyPaymentCard extends StatelessWidget {
  const VerifyPaymentCard({
    Key? key,
    required this.amount,
    required this.receiverPhone,
    required this.receiverName,
    required this.fees,
  }) : super(key: key);

  final int amount;
  final String receiverPhone;
  final String receiverName;
  final int fees;

  @override
  Widget build(BuildContext context) {
    Box userBox;
    userBox = Hive.box(Constants.UserBoxName);
    int currentBalance = userBox.get(Constants.BalanceStore);
    return DraggableCard(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn,
        padding: EdgeInsets.only(top: 10.0),
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Send",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "Ksh.${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w300),
                  ),
                  //Text("0.00001 BTC"),
                  SizedBox(height: 30),
                  Text("To: $receiverPhone",
                      style: const TextStyle(
                        color: Colors.grey,
                      )),

                  Row(children: [
                    Text(
                      receiverName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.edit_outlined,
                            color: Colors.black, size: 15),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ]),
                  SizedBox(height: 30),
                  Text(
                      "Fees: ${fees.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.0",
                      style: const TextStyle(
                        color: Colors.grey,
                      )),
                ],
              ),
            ),
            //    IconButton(
            //    icon: Icon(Icons.add, color: Colors.white),
            //   onPressed: () {}),
            ExpansionTile(
              onExpansionChanged: (bool currentState) {
                //print(currentState);
              },
              backgroundColor: Colors.white,
              title: Text(
                "DETAILS",
                style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500),
              ),
              children: <Widget>[
                ListTile(
                    trailing: Text(
                        "Ksh.${currentBalance.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                        style: const TextStyle(color: Colors.green)),
                    title: Text(
                      "Inital Balance",
                      style: const TextStyle(color: Colors.black),
                    )),
                ListTile(
                    trailing: Text(
                        "- Ksh.${(amount + fees).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                        style: const TextStyle(color: Colors.blue)),
                    title: Text(
                      "Transaction",
                      style: const TextStyle(color: Colors.black),
                    )),
                Divider(),
                ListTile(
                    trailing: Text(
                        "Ksh.${((currentBalance) - (amount + fees)).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                        style: const TextStyle(color: Colors.green)),
                    title: Text(
                      "Final Balance",
                      style: const TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmPage extends StatelessWidget {
  const ConfirmPage({
    Key? key,
    required this.amount,
    required this.receiverPhone,
    required this.receiverName,
    required this.fees,
  }) : super(key: key);

  final int amount;
  final String receiverPhone;
  final String receiverName;
  final int fees;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedContainer(
        duration: const Duration(seconds: 1),
        height: 50,
        width: screenWidth(context, percent: 0.8),
        decoration: BoxDecoration(
          color: Colors.greenAccent[400],
          boxShadow: [
            BoxShadow(
                color: Colors.grey[400]!.withOpacity(0.3),
                offset: const Offset(0, 13),
                blurRadius: 30)
          ],
        ),
        // ignore: deprecated_member_use
        child: FlatButton(
          onPressed: () async {
            Navigator.of(context).pushNamed("/pin");
          },
          color: Colors.transparent,
          child: Text(
            "Continue   ->",
            style: GoogleFonts.nunito(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: Center(
        child: VerifyPaymentCard(
            amount: (amount),
            fees: fees,
            receiverPhone: receiverPhone,
            receiverName: receiverName),
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  const DraggableCard({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  var _dragAlignment = Alignment.center;

  late Animation<Alignment> _animation;

  final _spring = const SpringDescription(
    mass: 7,
    stiffness: 1200,
    damping: 0.7,
  );

  double _normalizeVelocity(Offset velocity, Size size) {
    final normalizedVelocity = Offset(
      velocity.dx / size.width,
      velocity.dy / size.height,
    );
    return -normalizedVelocity.distance;
  }

  void _runAnimation(Offset velocity, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );

    final simulation =
        SpringSimulation(_spring, 0.0, 1.0, _normalizeVelocity(velocity, size));

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this)
      ..addListener(() => setState(() => _dragAlignment = _animation.value));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanStart: (details) => _controller.stop(canceled: true),
      onPanUpdate: (details) => setState(
        () => _dragAlignment += Alignment(
          details.delta.dx / (size.width / 2),
          details.delta.dy / (size.height / 2),
        ),
      ),
      onPanEnd: (details) =>
          _runAnimation(details.velocity.pixelsPerSecond, size),
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }
}

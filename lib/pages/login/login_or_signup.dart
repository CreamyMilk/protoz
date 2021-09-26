import 'package:flutter/material.dart';

import 'package:proto/utils/sizedMargins.dart';
import 'package:proto/widgets/corry_button.dart';
import 'package:proto/widgets/ic_ward.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({Key? key}) : super(key: key);

  @override
  _LoginOrSignupState createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup>
    with SingleTickerProviderStateMixin {
  late AnimationController c;

  @override
  void initState() {
    c = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    c.repeat(reverse: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent[400],
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            WadsLayout(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Farming for good & wealth.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Circular',
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontSize: 35,
                    ),
                  ),
                  const YMargin(10),
                  Text(
                    'Save and invest with AppAgric, the only farming app you really need.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Circular',
                      fontWeight: FontWeight.w400,
                      color: Colors.black87.withOpacity(0.8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Flexible(
                    child: CowryOutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      height: 53,
                      margin: EdgeInsets.zero,
                      textColor: Colors.black87,
                      color: Colors.white,
                      title: 'LOG IN',
                    ),
                  ),
                  const XMargin(20),
                  Flexible(
                    child: CowryButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/stepregister');
                      },
                      height: 53,
                      margin: EdgeInsets.zero,
                      color: Colors.white,
                      textColor: Colors.black87,
                      title: 'SIGN UP',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WadsLayout extends StatelessWidget {
  const WadsLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 50,
          right: 50,
          child: IcWad(
            rotation: 20,
          ),
        ),
        Positioned(
          top: screenHeight(context, percent: .72),
          right: 50,
          child: const IcWad(
            rotation: 80,
          ),
        ),
        Positioned(
          top: screenHeight(context, percent: .3),
          right: screenWidth(context, percent: .23),
          child: const IcWad(
            rotation: 0,
          ),
        ),
        Positioned(
          top: screenHeight(context, percent: .51),
          right: 45,
          child: const IcWad(
            rotation: -20,
          ),
        ),
        Positioned(
          top: screenHeight(context, percent: .35),
          left: 40,
          child: const IcWad(
            rotation: 80,
          ),
        ),
        Positioned(
          top: screenHeight(context, percent: .778),
          left: 40,
          child: const IcWad(
            rotation: 90,
          ),
        ),
        const Positioned(
          top: 50,
          left: 40,
          child: IcWad(
            rotation: -50,
          ),
        ),
      ],
    );
  }
}

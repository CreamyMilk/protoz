import 'package:flutter/material.dart';
import 'package:proto/utils/sized_margins.dart';
import 'package:proto/widgets/corry_button.dart';

class LoginOrSignup extends StatelessWidget {
  const LoginOrSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Hero(
                    tag: "logo",
                    child: Image(
                      height: 100,
                      width: 100,
                      image: AssetImage('assets/images/agric.jpg'),
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
                      height: 50,
                      margin: EdgeInsets.zero,
                      textColor: Colors.green,
                      color: Colors.green,
                      title: 'LOG IN',
                    ),
                  ),
                  const XMargin(20),
                  Flexible(
                    child: CowryButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/stepregister');
                      },
                      height: 50,
                      margin: EdgeInsets.zero,
                      color: Colors.green,
                      textColor: Colors.white,
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

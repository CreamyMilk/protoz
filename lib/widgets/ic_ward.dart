import 'dart:math';
import 'package:proto/utils/typeExtensions.dart';

import 'package:flutter/material.dart';

class IcWad extends StatefulWidget {
  final double rotation;

  const IcWad({Key key, @required this.rotation}) : super(key: key);
  @override
  _IcWad createState() => _IcWad();
}

class _IcWad extends State<IcWad> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> anim;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      lowerBound: Random().nextDouble() * 10,
      upperBound: 40,
      duration: Duration(milliseconds: 3600),
    );

    anim = controller
      ..drive(CurveTween(curve: Curves.slowMiddle))
      ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, snapshot) => Container(
        margin: EdgeInsets.only(top: 0 + anim.value),
        child: Transform.rotate(
          angle: widget.rotation.degrees,
          child: Opacity(
            opacity: 0.6,
            child: Icon(
              Icons.ten_k,
              color: Colors.white,
              size: 46,
            ),
          ),
        ),
      ),
    );
  }
}

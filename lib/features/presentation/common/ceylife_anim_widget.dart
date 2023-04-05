import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CeylifeAnimWidget extends StatelessWidget {
  final AnimationController controller;
  final String anim;

  const CeylifeAnimWidget(
      {Key key, @required this.controller, @required this.anim})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:
          Lottie.asset(anim, controller: controller, onLoaded: (composition) {
        if (controller.status == AnimationStatus.dismissed ||
            controller.status == AnimationStatus.completed) {
          controller.reset();
        }
        controller
          ..duration = composition.duration
          ..forward();
      }, fit: BoxFit.scaleDown),
      height: 135,
    );
  }
}

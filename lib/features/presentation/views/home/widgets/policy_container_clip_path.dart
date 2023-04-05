import 'package:flutter/material.dart';

class PolicyContainerClipPath extends CustomClipper<Path> {
  final bool isBadge;

  PolicyContainerClipPath({this.isBadge = false});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - (isBadge?14: 60));
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - (isBadge?14: 60));
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

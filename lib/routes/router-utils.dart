import 'package:flutter/material.dart';

PageRouteBuilder transitionBuilder(
    {required Widget child,
    Offset begin = const Offset(0.5, 0.0),
    Offset end = Offset.zero,
    Curve curve = Curves.ease}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

import 'package:flutter/material.dart';

Route<Object?> animateRoute(Widget widget, String animationType) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      CurvedAnimation curved =
          CurvedAnimation(parent: animation, curve: Curves.slowMiddle);
      Animation<double> animate =
          Tween<double>(begin: 0.0, end: 1.0).animate(curved);
      return switch (animationType) {
        'rotate' => RotationTransition(
            turns: animation,
            child: child,
          ),
        'scaleFade' => ScaleTransition(
            scale: animate,
            child: FadeTransition(
              opacity: animate,
              child: child,
            ),
          ),
        'scale' => ScaleTransition(
            scale: animate,
            child: child,
          ),
        _ => FadeTransition(
            opacity: animate,
            child: child,
          ),
      };
    },
  );
}

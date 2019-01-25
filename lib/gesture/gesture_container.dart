import 'package:flutter/material.dart';

class Actions {
  final GestureTapCallback onSwipeUp;
  final GestureTapCallback onSwipeDown;
  final GestureTapCallback onSwipeLeft;
  final GestureTapCallback onSwipeRight;

  Actions(
      {this.onSwipeUp, this.onSwipeDown, this.onSwipeLeft, this.onSwipeRight});
}

class GestureContainer extends StatelessWidget {
  final Widget child;
  final Actions actions;

  const GestureContainer({Key key, @required this.actions, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity > 0)
          actions.onSwipeLeft();
        else
          actions.onSwipeRight();
      },
      onVerticalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity > 0)
          actions.onSwipeDown();
        else
          actions.onSwipeUp();
      },
    );
  }
}

import 'package:flutter/material.dart';

class ColorBloc {}

class ColorProvider extends InheritedWidget {
  final ColorBloc bloc;

  ColorProvider({this.bloc, Widget child}) : super(child: child);

  factory ColorProvider.of(BuildContext context) =>
      context.ancestorWidgetOfExactType(ColorProvider);

  ColorBloc call() => bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class SelectColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColorProvider(
      bloc: ColorBloc(),
      child: Container(),
    );
  }
}

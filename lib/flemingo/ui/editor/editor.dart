import '../selection/screen.dart';
import 'package:flutter/material.dart';

class EditorBloc {}

class EditorProvider extends InheritedWidget {
  final EditorBloc bloc;

  EditorProvider({this.bloc, Widget child}) : super(child: child);

  factory EditorProvider.of(BuildContext context) =>
      context.ancestorWidgetOfExactType(EditorProvider);

  EditorBloc call() => bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class Editor extends StatelessWidget {
  final FScreen screen;

  const Editor(this.screen);

  @override
  Widget build(BuildContext context) {
    return EditorProvider(
      bloc: EditorBloc(),
      child: Container(),
    );
  }
}

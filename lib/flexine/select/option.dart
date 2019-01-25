import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class OptionBloc {
  final List<String> titles;

  OptionBloc(this.titles) {
    _valueSubject.sink.add(titles[0]);
    _controller.stream.listen(_update);
  }

  Sink<String> get sink => _controller.sink;
  final _controller = StreamController<String>();

  Stream<String> get value => _valueSubject.stream;
  final _valueSubject = BehaviorSubject<String>();

  void _update(String s) {
    _valueSubject.sink.add(s);
  }
}

class OptionProvider extends InheritedWidget {
  final OptionBloc bloc;

  OptionProvider({this.bloc, Widget child}) : super(child: child);

  OptionBloc call() => bloc;

  factory OptionProvider.of(BuildContext context) =>
      context.ancestorWidgetOfExactType(OptionProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class SelectOption extends StatelessWidget {
  final List<String> titles;
  final Sink<int> sink;
  static List<String> orientation = [
    "Horizontal (0)",
    "Verticle (1) ",
  ];

  static List<String> paintingStyle = [
    "Fill (0)",
    "Stroke (1) ",
  ];

  static List<String> shapes = [
    "Rectangle (0)",
    "Circle (1) ",
  ];

  const SelectOption({this.titles, this.sink});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> items = titles
        .map((text) => DropdownMenuItem(
              child: Text(text),
              value: text,
            ))
        .toList();
    final bloc = OptionBloc(titles);
    return OptionProvider(
      bloc: bloc,
      child: StreamBuilder<String>(
        stream: bloc.value,
        builder: (context, snapshot) {
          sink.add(titles.indexOf(snapshot.data));
          return DropdownButton<String>(
            onChanged: (value) {
              bloc.sink.add(value);
            },
            value: snapshot.data,
            items: items,
          );
        },
      ),
    );
  }
}

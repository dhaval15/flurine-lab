import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../ui/commons/styling.dart';
import 'raw/framework.dart';

class InsetsBloc {
  final Sink<FInset> consumer;

  Sink<int> get left => _leftController.sink;
  final _leftController = StreamController<int>();

  Sink<int> get right => _rightController.sink;
  final _rightController = StreamController<int>();

  Sink<int> get top => _topController.sink;
  final _topController = StreamController<int>();

  Sink<int> get bottom => _bottomController.sink;
  final _bottomController = StreamController<int>();

  InsetsBloc(this.consumer) {
    Observable.combineLatest4(
        _leftController.stream,
        _rightController.stream,
        _topController.stream,
        _bottomController.stream,
        (left, right, top, bottom) => FInset(
              left: left,
              right: right,
              bottom: bottom,
              top: top,
            )).listen(consumer.add);
  }
}

class InsetsProvider extends InheritedWidget {
  final InsetsBloc bloc;

  InsetsProvider({this.bloc, Widget child}) : super(child: child);

  factory InsetsProvider.of(BuildContext context) =>
      context.ancestorWidgetOfExactType(InsetsProvider);

  InsetsBloc call() => bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class SelectInsets extends StatelessWidget {
  final Sink<FInset> sink;

  const SelectInsets(this.sink);

  @override
  Widget build(BuildContext context) {
    var bloc = InsetsBloc(sink);
    return InsetsProvider(
      bloc: bloc,
      child: Column(
        children: <Widget>[
          PairWidget(
            title: 'Left',
            child: SelectNumber(
              sink: bloc.left,
              initial: 0,
              bound: Bound(0, null),
              stepper: 5,
            ),
          ),
          PairWidget(
            title: 'Right',
            child: SelectNumber(
              sink: bloc.right,
              initial: 0,
              bound: Bound(0, null),
              stepper: 5,
            ),
          ),
          PairWidget(
            title: 'Top',
            child: SelectNumber(
              sink: bloc.top,
              initial: 0,
              bound: Bound(0, null),
              stepper: 5,
            ),
          ),
          PairWidget(
            title: 'Bottom',
            child: SelectNumber(
              sink: bloc.bottom,
              initial: 0,
              bound: Bound(0, null),
              stepper: 5,
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flurine_launcher/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class NumBloc {
  int _value;
  final Sink<int> consumer;
  final int stepper;

  Sink<String> get sink => _controller.sink;
  final _controller = StreamController<String>();

  Stream<int> get value => _valueSubject.stream;
  final _valueSubject = BehaviorSubject<int>();

  void increment() {
    _value = _value + stepper;
    _add();
  }

  void decrement() {
    _value = _value - stepper;
    _add();
  }

  void _add() {
    _valueSubject.add(_value);
    consumer.add(_value);
  }

  void _update(String s) {
    _value = int.parse(s);
    _add();
  }

  NumBloc({int initial, this.consumer, this.stepper}) {
    _value = initial;
    _controller.stream.listen(_update);
    if (initial != null) _valueSubject.sink.add(initial);
  }
}

class NumProvider extends InheritedWidget {
  final NumBloc bloc;

  NumProvider({this.bloc, Widget child}) : super(child: child);

  factory NumProvider.of(BuildContext context) =>
      context.ancestorWidgetOfExactType(NumProvider);

  NumBloc call() => bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class SelectNumber extends StatelessWidget {
  final Bound bound;
  final int stepper;
  final int initial;
  final Sink<int> sink;

  SelectNumber({Key key, this.bound, this.stepper, this.initial, this.sink})
      : super(key: key) {
    sink.add(initial);
  }

  @override
  Widget build(BuildContext context) {
    var bloc = NumBloc(initial: initial, consumer: sink, stepper: stepper);
    return NumProvider(
      bloc: bloc,
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Icon(Icons.remove),
            onTap: bloc.decrement,
          ),
          Span(width: 16),
          Flexible(
            flex: 1,
            child: StreamBuilder(
              stream: bloc.value,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return TextField(
                  controller:
                      TextEditingController(text: snapshot.data.toString()),
                  inputFormatters: [BoundFormatter(bound)],
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: bloc.sink.add,
                  style: DefaultTextStyle.of(context).style.merge(TextStyle(
                        fontSize: 15,
                      )),
                );
              },
            ),
          ),
          Span(width: 16),
          GestureDetector(
            child: Icon(Icons.add),
            onTap: bloc.increment,
          ),
        ],
      ),
    );
  }
}

class Bound {
  final int lower;
  final int upper;

  Bound(this.lower, this.upper);
}

class BoundFormatter extends TextInputFormatter {
  final Bound bound;

  BoundFormatter(this.bound);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int value = int.parse(newValue.text.isEmpty ? "0" : newValue.text);
    if (bound.upper != null && value > bound.upper)
      value = bound.upper;
    else if (bound.lower != null && value < bound.lower) value = bound.lower;
    return newValue.copyWith(
      text: value.toString(),
    );
  }
}

import 'dart:async';

import 'package:flurine_launcher/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../commons/flexine.dart';
import '../commons/styling.dart';
import 'raw/framework.dart';
import 'inset.dart';

class FContainer extends Flexine {
  final Flexine child;
  final FBoxDecoration decoration;

  final FInset padding;

  final double width;

  final double height;

  final FInset margin;

  FContainer({
    this.child,
    this.decoration,
    this.padding,
    this.width,
    this.height,
    this.margin,
  }) : super('container');

  factory FContainer.fromJson(Map<String, dynamic> data) => FContainer(
        child: Flexine.fromJson(data['child']),
        decoration: FBoxDecoration.fromJson(data['decoration']),
        padding: FInset.fromJson(data['padding']),
        width: data['width'],
        height: data['height'],
        margin: FInset.fromJson(data['margin']),
      );

  @override
  Container toFlexible() => Container(
        child: child.toFlexible(),
        decoration: decoration.toStyle(),
        padding: padding.toStyle(),
        width: width,
        height: height,
        margin: margin.toStyle(),
      );

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'child': child.toJson(),
        'decoration': decoration.toJson(),
        'padding': padding.toJson(),
        'width': width,
        'height': height,
        'margin': margin.toJson(),
      };
}

class ContainerBloc {
  final Sink<Flexine> consumer;

  Sink<int> get width => _widthController.sink;
  final _widthController = StreamController<int>();

  Sink<int> get height => _heightController.sink;
  final _heightController = StreamController<int>();

  Sink<FInset> get padding => _paddingController.sink;
  final _paddingController = StreamController<FInset>();

  Sink<FInset> get margin => _marginController.sink;
  final _marginController = StreamController<FInset>();

  Sink<FBoxDecoration> get decoration => _decorationController.sink;
  final _decorationController = StreamController<FBoxDecoration>();

  Sink<Flexine> get child => _childController.sink;
  final _childController = StreamController<Flexine>();

  ContainerBloc(this.consumer) {
    // Add Decoration

    Observable.combineLatest5(
        _widthController.stream,
        _heightController.stream,
        _paddingController.stream,
        _marginController.stream,
        _childController.stream,
        (width, height, padding, margin, child) => FContainer(
              child: child,
              width: width,
              height: height,
              decoration: null,
              margin: margin,
              padding: padding,
            )).listen(consumer.add);
  }
}

class ContainerProvider extends InheritedWidget {
  final ContainerBloc bloc;

  ContainerProvider({this.bloc, Widget child}) : super(child: child);

  factory ContainerProvider.of(BuildContext context) =>
      context.ancestorWidgetOfExactType(ContainerProvider);

  ContainerBloc call() => bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class SelectContainer extends StatelessWidget {
  final Sink<Flexine> sink;

  const SelectContainer(this.sink);

  @override
  Widget build(BuildContext context) {
    var bloc = ContainerBloc(sink);
    return ContainerProvider(
      bloc: bloc,
      child: ListView(
        children: <Widget>[
          PairWidget(
            title: 'Width',
            child: SelectNumber(
              sink: bloc.width,
              initial: 200,
              bound: Bound(0, null),
              stepper: 5,
            ),
          ),
          PairWidget(
            title: 'Height',
            child: SelectNumber(
              sink: bloc.height,
              initial: 100,
              bound: Bound(0, null),
              stepper: 5,
            ),
          ),
          Div(),
          Text(
            'Padding',
            style: TextStyle(fontSize: 18),
          ),
          Padding(
            padding: EdgeInsets.all(4),
            child: SelectInsets(bloc.padding),
          ),
          Text(
            'Margin',
            style: TextStyle(fontSize: 18),
          ),
          Padding(
            padding: EdgeInsets.all(4),
            child: SelectInsets(bloc.margin),
          ),
          PairWidget(
            title: 'Child',
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SelectWidget(bloc.child),
                    fullscreenDialog: true));
              },
              child: Container(
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}

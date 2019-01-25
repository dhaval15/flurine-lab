import 'dart:async';

import 'package:flurine_launcher/flexine/models/common.dart';
import 'package:flurine_launcher/flexine/models/styling.dart';
import 'package:flurine_launcher/flexine/models/widgets.dart';
import 'package:flurine_launcher/flexine/select/extra.dart';
import 'package:flurine_launcher/flexine/select/num.dart';
import 'package:flurine_launcher/flexine/select/option.dart';
import 'package:flurine_launcher/flexine/select/string.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class EditorBloc {
  Sink<String> get text => _textController.sink;
  final _textController = StreamController<String>();

  Sink<int> get fontSize => _fontSizeController.sink;
  final _fontSizeController = StreamController<int>();

  Sink<int> get fontWeight => _fontWeightController.sink;
  final _fontWeightController = StreamController<int>();

  Sink<int> get style => _styleController.sink;
  final _styleController = StreamController<int>();

  Sink<int> get strokeWidth => _strokeWidthController.sink;
  final _strokeWidthController = StreamController<int>();

  Stream<Flexine> get flexine => _flexineSubject.stream;
  final _flexineSubject = BehaviorSubject<Flexine>();

  EditorBloc() {
    Observable.combineLatest5(
        _textController.stream,
        _fontSizeController.stream,
        _fontWeightController.stream,
        _styleController.stream,
        _strokeWidthController.stream,
        (text, fontSize, fontWeight, style, strokeWidth) {
      return FText(
        text: text,
        fontWeight: fontWeight.toInt(),
        paint: FPaint(
          color: Colors.white.value,
          strokeWidth: strokeWidth.toDouble(),
          style: style,
        ),
        fontSize: fontSize.toDouble(),
      );
    }).listen(_update);
  }

  void _update(Flexine event) {
    _flexineSubject.add(event);
  }
}

class EditorProvider extends InheritedWidget {
  final EditorBloc bloc;

  EditorProvider({this.bloc, Widget child}) : super(child: child);

  EditorBloc call() => bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  factory EditorProvider.of(BuildContext context) =>
      context.ancestorWidgetOfExactType(EditorProvider);
}

class Editor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flurine Lab')),
      body: Container(
        child: EditorProvider(
          bloc: EditorBloc(),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: LivePreview(),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: SelectText(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LivePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Transform.scale(
        scale: 0.5,
        child: Center(
          child: StreamBuilder<Flexine>(
            stream: EditorProvider.of(context)().flexine,
            builder: (BuildContext context, AsyncSnapshot<Flexine> snapshot) {
              final flexine = snapshot.hasData
                  ? snapshot.data
                  : FText(
                      text: 'Hello',
                      paint: FPaint(
                        color: Colors.white.value,
                        strokeWidth: 1,
                        style: PaintingStyle.fill.index,
                      ),
                      fontSize: 40,
                      fontWeight: 3,
                    );
              return flexine.toFlexible();
            },
          ),
        ),
      ),
    );
  }
}

class SelectText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = EditorProvider.of(context)();
    return ListView(
      children: <Widget>[
        PairWidget(
          title: 'Text',
          child: SelectString(
            sink: bloc.text,
            initial: 'Type Here',
          ),
        ),
        PairWidget(
          title: 'Size',
          child: SelectNumber(
            bound: Bound(1, null),
            sink: bloc.fontSize,
            initial: 14,
            stepper: 4,
          ),
        ),
        PairWidget(
          title: 'Weight',
          child: SelectNumber(
            sink: bloc.fontWeight,
            bound: Bound(1, FontWeight.values.length),
            stepper: 1,
            initial: FontWeight.normal.index,
          ),
        ),
        PairWidget(
          title: 'Style',
          child: SelectOption(
            sink: bloc.style,
            titles: ['Fill', 'Stroke'],
          ),
        ),
        PairWidget(
          title: 'StrokeWidth',
          child: SelectNumber(
            stepper: 1,
            bound: Bound(1, null),
            sink: bloc.strokeWidth,
            initial: 1,
          ),
        ),
      ],
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../commons/flexine.dart';
import '../commons/styling.dart';
import 'raw/framework.dart';

class FText extends Flexine {
  final String text;
  final double fontSize;
  final FPaint paint;
  final int fontWeight;
  final int letterSpacing;
  final int wordSpacing;

  FText({
    this.fontWeight,
    this.paint,
    this.text,
    this.fontSize,
    this.letterSpacing,
    this.wordSpacing,
  }) : super('text');

  factory FText.fromJson(Map<String, dynamic> data) => FText(
        text: data['text'],
        fontSize: data['fontSize'],
        paint: FPaint.fromJson(data['paint']),
        fontWeight: data['fontWeight'],
        letterSpacing: data['letterSpacing'],
        wordSpacing: data['wordSpacing'],
      );

  @override
  Text toFlexible() => Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          foreground: paint.toStyle(),
          fontWeight: FontWeight.values[fontWeight],
          letterSpacing: letterSpacing.toDouble(),
          wordSpacing: wordSpacing.toDouble(),
        ),
      );

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'text': text,
        'fontSize': fontSize,
        'fontWeight': fontWeight,
        'foreground': paint,
        'letterSpacing': letterSpacing,
        'wordSpacing': wordSpacing,
      };
}

class TextBloc {
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

  Sink<int> get letterSpacing => _letterSpacingController.sink;
  final _letterSpacingController = StreamController<int>();

  Sink<int> get wordSpacing => _wordSpacingController.sink;
  final _wordSpacingController = StreamController<int>();

  final Sink<Flexine> consumer;

  TextBloc(this.consumer) {
    Observable.combineLatest7(
        _textController.stream,
        _fontSizeController.stream,
        _fontWeightController.stream,
        _styleController.stream,
        _strokeWidthController.stream,
        _letterSpacingController.stream,
        _wordSpacingController.stream, (text, fontSize, fontWeight, style,
            strokeWidth, letterSpacing, wordSpacing) {
      return FText(
        text: text,
        fontWeight: fontWeight.toInt(),
        paint: FPaint(
          color: Colors.white.value,
          strokeWidth: strokeWidth.toDouble(),
          style: style,
        ),
        letterSpacing: letterSpacing,
        fontSize: fontSize.toDouble(),
        wordSpacing: wordSpacing,
      );
    }).listen(consumer.add);
  }
}

class TextProvider extends InheritedWidget {
  final TextBloc bloc;

  TextProvider({this.bloc, Widget child}) : super(child: child);

  factory TextProvider.of(BuildContext context) =>
      context.ancestorWidgetOfExactType(TextProvider);

  TextBloc call() => bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class SelectText extends StatelessWidget {
  final Sink<Flexine> sink;

  SelectText(this.sink);

  @override
  Widget build(BuildContext context) {
    var bloc = TextBloc(sink);
    return TextProvider(
      bloc: bloc,
      child: ListView(
        children: <Widget>[
          PairWidget(
            title: 'Text',
            child: SelectString(
              sink: bloc.text,
              initial: 'Flurine',
            ),
          ),
          PairWidget(
            title: 'Size',
            child: SelectNumber(
              bound: Bound(1, null),
              sink: bloc.fontSize,
              initial: 48,
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
            title: 'Stroke Width',
            child: SelectNumber(
              stepper: 1,
              bound: Bound(1, null),
              sink: bloc.strokeWidth,
              initial: 1,
            ),
          ),
          PairWidget(
            title: 'Letter Spacing',
            child: SelectNumber(
              stepper: 1,
              bound: Bound(null, null),
              sink: bloc.letterSpacing,
              initial: 1,
            ),
          ),
          PairWidget(
            title: 'Word Spacing',
            child: SelectNumber(
              stepper: 1,
              bound: Bound(null, null),
              sink: bloc.wordSpacing,
              initial: 1,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../commons/flexine.dart';
import '../commons/styling.dart';

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

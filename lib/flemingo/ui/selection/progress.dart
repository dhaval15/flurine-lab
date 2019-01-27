import 'package:flutter/material.dart';
import '../commons/flexine.dart';

class FProgress extends Flexine {
  final int progressType;
  final int foregroundColor;
  final int backgroundColor;
  final double value;
  final double strokeWidth;

  FProgress(
      {this.progressType,
      this.strokeWidth,
      this.foregroundColor,
      this.backgroundColor,
      this.value})
      : super('progress');

  factory FProgress.fromJson(Map<String, dynamic> data) => FProgress(
        progressType: data['progressType'],
        strokeWidth: data['strokeWidth'],
        backgroundColor: data['backgroundColor'],
        foregroundColor: data['foregroundColor'],
        value: data['value'],
      );

  @override
  ProgressIndicator toFlexible() {
    return progressType == 0
        ? LinearProgressIndicator(
            backgroundColor: Color(backgroundColor),
            valueColor: AlwaysStoppedAnimation<Color>(Color(foregroundColor)),
            value: value,
          )
        : CircularProgressIndicator(
            backgroundColor: Color(backgroundColor),
            valueColor: AlwaysStoppedAnimation<Color>(Color(foregroundColor)),
            value: value,
            strokeWidth: strokeWidth,
          );
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'progressType': progressType,
        'strokeWidth': strokeWidth,
        'backgroundColor': backgroundColor,
        'foregroundColor': foregroundColor,
        'value': value,
      };
}

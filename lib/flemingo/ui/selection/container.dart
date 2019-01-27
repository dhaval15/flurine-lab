import 'package:flutter/material.dart';
import '../commons/flexine.dart';
import '../commons/styling.dart';

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

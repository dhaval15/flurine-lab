import 'package:flutter/material.dart';

abstract class FStyle {
  toStyle();

  Map<String, dynamic> toJson();
}

class FBoxDecoration extends FStyle {
  final int color;

  final double radius;

  final int shape;

  final FGradient gradient;

  FBoxDecoration({this.gradient, this.shape, this.color, this.radius});

  factory FBoxDecoration.fromJson(Map<String, dynamic> data) => FBoxDecoration(
        gradient: FGradient.fromJson(data['gradient']),
        shape: data['shape'],
        radius: data['radius'],
        color: data['color'],
      );

  @override
  BoxDecoration toStyle() => BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.circular(radius),
        shape: BoxShape.values[shape],
        gradient: gradient.toStyle(),
      );

  @override
  Map<String, dynamic> toJson() => {
        'color': color,
        'radius': radius,
        'shape': shape,
        'gradient': gradient.toJson(),
      };
}

class FGradient extends FStyle {
  final List<int> colors;
  final int orientation;

  FGradient({this.colors, this.orientation});

  factory FGradient.fromJson(Map<String, dynamic> data) => FGradient(
        colors: data['colors'],
        orientation: data['orientation'],
      );

  @override
  LinearGradient toStyle() => LinearGradient(
        colors: colors.map((color) => Color(color)),
        begin: orientation == 0 ? Alignment.centerLeft : Alignment.topCenter,
        end: orientation == 0 ? Alignment.centerRight : Alignment.bottomCenter,
      );

  @override
  Map<String, dynamic> toJson() => {
        'colors': colors,
        'orientation': orientation,
      };
}

class FInset extends FStyle {
  final double left;
  final double right;
  final double top;
  final double bottom;

  FInset({this.left, this.right, this.top, this.bottom});

  factory FInset.fromJson(Map<String, dynamic> data) => FInset(
        top: data['top'],
        bottom: data['bottom'],
        right: data['right'],
        left: data['left'],
      );

  @override
  EdgeInsets toStyle() => EdgeInsets.only(
        left: left,
        right: right,
        bottom: bottom,
        top: top,
      );

  @override
  Map<String, dynamic> toJson() => {
        'left': left,
        'top': top,
        'right': right,
        'bottom': bottom,
      };
}

class FPaint extends FStyle {
  final int style;
  final double strokeWidth;
  final int color;

  FPaint({
    this.style,
    this.strokeWidth,
    this.color,
  });

  factory FPaint.fromJson(Map<String, dynamic> data) => FPaint(
        style: data['style'],
        strokeWidth: data['strokeWidth'],
        color: data['color'],
      );

  @override
  Paint toStyle() => Paint()
    ..style = PaintingStyle.values[style]
    ..strokeWidth = strokeWidth
    ..color = Color(color);

  @override
  Map<String, dynamic> toJson() => {
        'color': color,
        'style': style,
        'strokeWidth': strokeWidth,
      };
}

class FAlignment extends FStyle {
  final double x;
  final double y;

  FAlignment(this.x, this.y);

  factory FAlignment.fromJson(Map<String, dynamic> data) =>
      FAlignment(data['x'], data['y']);

  @override
  Alignment toStyle() {
    return Alignment(x, y);
  }

  @override
  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
      };
}

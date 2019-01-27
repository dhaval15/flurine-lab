import 'package:flutter/material.dart';
import '../commons/flexine.dart';

class FStack extends Flexine {
  final List<Flexine> children;

  FStack({this.children}) : super('stack');

  factory FStack.fromJson(Map<String, dynamic> data) => FStack(
        children: data['children'].map((d) => Flexine.fromJson(d)),
      );

  @override
  Stack toFlexible() {
    var children =
        this.children.map((Flexine child) => child.toFlexible()).toList();
    return Stack(
      children: children,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'children': children.map((f) => f.toJson()).toList(),
      };
}

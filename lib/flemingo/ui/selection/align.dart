import 'package:flutter/material.dart';
import '../commons/flexine.dart';
import '../commons/styling.dart';

class FAlign extends Flexine {
  final Flexine child;
  final FAlignment alignment;

  FAlign({this.alignment, this.child}) : super('align');

  factory FAlign.fromJson(Map<String, dynamic> data) => FAlign(
        child: Flexine.fromJson(data['child']),
        alignment: FAlignment.fromJson(data['alignment']),
      );

  @override
  Align toFlexible() {
    return Align(
      child: child.toFlexible(),
      alignment: alignment.toStyle(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'child': child.toJson(),
        'alignment': alignment.toJson(),
      };
}

import 'package:flutter/material.dart';
import '../commons/flexine.dart';

class FScreen extends Flexine {
  final String key;
  final Flexine child;

  FScreen({this.key, this.child}) : super('screen');

  @override
  Widget toFlexible() {
    return child.toFlexible();
  }

  factory FScreen.fromJson(Map<String, dynamic> data) => FScreen(
        key: data['key'],
        child: Flexine.fromJson(data['child']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'key': key,
        'child': child.toJson(),
      };
}

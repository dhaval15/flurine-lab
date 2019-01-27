import 'package:flutter/material.dart';
import '../commons/flexine.dart';

class FScreen extends Flexine {
  final String key;
  final Flexine child;
  final String title;

  FScreen({this.title, this.key, this.child}) : super('screen');

  @override
  Widget toFlexible() {
    return child.toFlexible();
  }

  factory FScreen.fromJson(Map<String, dynamic> data) => FScreen(
        key: data['key'],
        child: Flexine.fromJson(data['child']),
        title: data['title'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'key': key,
        'title': title,
        'child': child.toJson(),
      };
}

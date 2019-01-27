import 'package:flutter/material.dart';
import '../commons/flexine.dart';

class FList extends Flexine {
  final List<Flexine> children;
  final int orientation;

  FList({this.orientation, this.children}) : super('list');

  factory FList.fromJson(Map<String, dynamic> data) => FList(
        children: data['children'].map((d) => Flexine.fromJson(d)),
        orientation: data['orientation'],
      );

  @override
  ListView toFlexible() {
    return ListView.builder(
      itemCount: children.length,
      scrollDirection: Axis.values[orientation],
      itemBuilder: (BuildContext context, int index) {
        return children[index].toFlexible();
      },
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'orientation': orientation,
        'children': children.map((f) => f.toJson()).toList(),
      };
}

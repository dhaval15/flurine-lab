import 'package:flutter/material.dart';
import '../commons/flexine.dart';
import '../../formula/formula.dart';

class FStreamBuilder extends Flexine {
  final Map<String, Formula> formulas;

  FStreamBuilder({this.formulas}) : super('streambuilder');

  @override
  Widget toFlexible() {
    return _SB(
      stream: null,
    );
  }

  factory FStreamBuilder.fromJson(Map<String, dynamic> data) =>
      FStreamBuilder(formulas: data['formulas']);

  @override
  Map<String, dynamic> toJson() {
    return null;
  }
}

class _SB extends StatefulWidget {
  final Stream<Map<String, dynamic>> stream;

  const _SB({Key key, this.stream}) : super(key: key);

  @override
  _SBState createState() {
    return _SBState();
  }
}

class _SBState extends State<_SB> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Flexine.fromJson(snapshot.data).toFlexible()
            : SizedBox();
      },
    );
  }
}

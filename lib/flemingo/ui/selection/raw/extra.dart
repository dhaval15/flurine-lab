import 'package:flurine_launcher/widgets/utils.dart';
import 'package:flutter/material.dart';

class PairWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const PairWidget({Key key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: TextStyle(fontSize: 15),
            ),
          ),
          const Span(width: 8),
          Flexible(
            child: child,
            flex: 1,
          ),
        ],
      ),
    );
  }
}

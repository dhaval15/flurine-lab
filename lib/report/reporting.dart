import 'package:flutter/material.dart';

/*
  UI Error Codes :
    UI01 : Unable To Get Data From Stream [SelectText]

*/

class ReportError extends StatelessWidget {
  final String error;
  final Color color;

  const ReportError({@required this.error, this.color = Colors.black})
      : super();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Error : $error',
      style: TextStyle(fontSize: 20, color: color),
    );
  }
}

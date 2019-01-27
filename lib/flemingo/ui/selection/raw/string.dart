import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectString extends StatelessWidget {
  final TextInputType inputType;
  final String initial;
  final List<TextInputFormatter> inputFormatter;
  final Sink<String> sink;

  SelectString({
    Key key,
    this.inputType = TextInputType.text,
    this.inputFormatter,
    this.initial,
    this.sink,
  }) : super(key: key) {
    sink.add(initial);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: initial),
      inputFormatters: inputFormatter,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      onChanged: (text) {
        sink.add(text);
      },
      style: DefaultTextStyle.of(context).style.merge(TextStyle(
            fontSize: 15,
          )),
    );
  }
}

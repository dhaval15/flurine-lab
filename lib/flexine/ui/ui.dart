import 'dart:async';

import 'package:flurine_launcher/flexine/models/common.dart';
import 'package:flurine_launcher/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

mixin SelectionStateMixin<T> {
  T get value;
}

dynamic getValueFromMixinKey(dynamic key) => key.currentState.value;

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

class StringSelection extends StatefulWidget {
  final TextInputType inputType;
  final String initial;
  final List<TextInputFormatter> inputFormatter;

  const StringSelection(
      {Key key,
      this.inputType = TextInputType.text,
      this.inputFormatter,
      this.initial})
      : super(key: key);

  @override
  StringSelectionState createState() {
    return StringSelectionState();
  }
}

class StringSelectionState extends State<StringSelection>
    with SelectionStateMixin<String> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: widget.inputFormatter,
      controller: controller,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      style: DefaultTextStyle.of(context).style.merge(TextStyle(
            fontSize: 15,
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  String get value => controller.text;
}

class NumberSelection extends StatefulWidget {
  final Bound bound;
  final int stepper;
  final int initial;

  const NumberSelection({Key key, this.bound, this.stepper, this.initial})
      : super(key: key);

  @override
  _NumberSelectionState createState() => _NumberSelectionState();
}

class _NumberSelectionState extends State<NumberSelection>
    with SelectionStateMixin<int> {
  GlobalKey<StringSelectionState> _key = GlobalKey();
  int _value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: Icon(Icons.remove),
          onTap: _decrement,
        ),
        Span(width: 16),
        Flexible(
          flex: 1,
          child: StringSelection(
            key: _key,
            initial: widget.initial.toString(),
            inputType: TextInputType.number,
            inputFormatter: [BoundFormatter(widget.bound)],
          ),
        ),
        Span(width: 16),
        GestureDetector(
          child: Icon(Icons.add),
          onTap: _increment,
        ),
      ],
    );
  }

  _increment() {
    _key.currentState.controller.text = (value + widget.stepper).toString();
  }

  _decrement() {
    _key.currentState.controller.text = (value - widget.stepper).toString();
  }

  @override
  int get value => int.parse(_key.currentState.value);
}

// Extra Utils

class BoundFormatter extends TextInputFormatter {
  final Bound bound;

  BoundFormatter(this.bound);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int value = int.parse(newValue.text.isEmpty ? "0" : newValue.text);
    if (bound.upper != null && value > bound.upper)
      value = bound.upper;
    else if (bound.lower != null && value < bound.lower) value = bound.lower;
    return newValue.copyWith(
      text: value.toString(),
    );
  }
}

class EnumSelection extends StatefulWidget {
  final List<String> pairs;
  static List<String> orientation = [
    "Horizontal (0)",
    "Verticle (1) ",
  ];

  static List<String> paintingStyle = [
    "Fill (0)",
    "Stroke (1) ",
  ];

  static List<String> shapes = [
    "Rectangle (0)",
    "Circle (1) ",
  ];

  const EnumSelection({Key key, this.pairs}) : super(key: key);

  @override
  EnumSelectionState createState() {
    return EnumSelectionState();
  }
}

class EnumSelectionState extends State<EnumSelection>
    with SelectionStateMixin<int> {
  String _value;

  @override
  void initState() {
    super.initState();
    _value = widget.pairs[0];
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> items = widget.pairs
        .map((text) => DropdownMenuItem(
              child: Text(text),
              value: text,
            ))
        .toList();
    return DropdownButton(
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
      value: _value,
      items: items,
    );
  }

  @override
  int get value => widget.pairs.indexOf(_value);
}

class SwitchSelection extends StatefulWidget {
  final bool initial;

  const SwitchSelection({Key key, this.initial = false}) : super(key: key);

  @override
  SwitchSelectionState createState() {
    return SwitchSelectionState();
  }
}

class ColorSelection extends StatefulWidget {
  final Color initial;

  const ColorSelection({Key key, this.initial}) : super(key: key);

  @override
  _ColorSelectionState createState() => _ColorSelectionState();
}

class _ColorSelectionState extends State<ColorSelection>
    with SelectionStateMixin<int> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  int get value => widget.initial.value;
}

class SwitchSelectionState extends State<SwitchSelection>
    with SelectionStateMixin<bool> {
  bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _value,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
    );
  }

  @override
  bool get value => _value;
}

class LivePreview extends StatefulWidget {
  final Flexine flexine;

  const LivePreview({Key key, this.flexine}) : super(key: key);

  @override
  _LivePreviewState createState() => _LivePreviewState();
}

class _LivePreviewState extends State<LivePreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Transform.scale(
        scale: 0.5,
        child: Center(child: widget.flexine.toFlexible()),
      ),
    );
  }
}

class Bound {
  final int lower;
  final int upper;

  Bound(this.lower, this.upper);
}

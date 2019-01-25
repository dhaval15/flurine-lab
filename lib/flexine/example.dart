import 'package:flurine_launcher/database/database.dart';
import 'package:flurine_launcher/flexine/models/common.dart';
import 'package:flurine_launcher/flexine/models/styling.dart';
import 'package:flurine_launcher/flexine/models/widgets.dart';
import 'package:flurine_launcher/flexine/ui/ui.dart';
import 'package:flurine_launcher/flexine/ui/selection.dart' as selection;
import 'package:flurine_launcher/widgets/utils.dart';

import 'package:flutter/material.dart';

class Example extends StatefulWidget {
  const Example({Key key}) : super(key: key);

  @override
  ExampleState createState() {
    return ExampleState();
  }
}

class ExampleState extends State<Example> {
  List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    FlexineDatabase.of(context).init();
    _initWidgets();
  }

  _initWidgets() async {
    widgets =
        (await FlexineDatabase.of(context).find({})).map((f) => f.toFlexible());
  }

  @override
  Widget build(BuildContext context) {
    return FlexineDatabase(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: If(
              flag: widgets != null,
              child: Column(
                children: widgets,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    FlexineDatabase.of(context).close();
  }
}

class E extends StatefulWidget {
  @override
  EState createState() {
    return EState();
  }
}

class EState extends State<E> {
  Flexine flexine = FText(
    text: 'A',
    paint: FPaint(
      color: Colors.green.value,
      strokeWidth: 1,
      style: PaintingStyle.stroke.index,
    ),
  );
  GlobalKey<selection.TextSelectionState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: LivePreview(
            flexine: flexine,
          ),
        ),
        FlatButton(
          onPressed: _refresh,
          child: Text('Refresh'),
        ),
        Flexible(
          flex: 1,
          child: selection.TextSelection(
            key: key,
          ),
        ),
      ],
    );
  }

  void _refresh() {
    setState(() {
      flexine = key.currentState.flexine;
    });
  }
}

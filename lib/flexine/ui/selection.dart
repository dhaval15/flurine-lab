import 'package:flurine_launcher/database/database.dart';
import 'package:flurine_launcher/flexine/models/common.dart';
import 'package:flurine_launcher/flexine/models/styling.dart';
import 'package:flurine_launcher/flexine/models/widgets.dart';
import 'package:flurine_launcher/flexine/ui/common.dart';

import 'package:flurine_launcher/flexine/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flurine_launcher/flexine/example.dart';

mixin SelectionMixin {
  Flexine get flexine;
}

class SScreen extends StatefulWidget {
  final List<MapEntry> texts = [
    MapEntry('Container', (context) => ContainerSelection()),
    MapEntry('Formula', (context) => FormulaSelection()),
    MapEntry('Stack', (context) => SStack()),
    MapEntry('Image', (context) => ImageSelection()),
    MapEntry('Text', (context) => TextSelection()),
    MapEntry('Progress Bar', (context) => ProgressSelection()),
    MapEntry('List', (context) => SList()),
    MapEntry('Align', (context) => AlignSelection()),
  ];

  @override
  _SScreenState createState() => _SScreenState();
}

class _SScreenState extends State<SScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.texts.length,
      itemBuilder: (BuildContext context, int index) {
        var entry = widget.texts[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: entry.value));
          },
          child: ListTile(
            title: Text(entry.key),
          ),
        );
      },
    );
  }
}

class ContainerSelection extends StatefulWidget {
  @override
  _ContainerSelectionState createState() => _ContainerSelectionState();
}

class _ContainerSelectionState extends State<ContainerSelection> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SStack extends StatefulWidget {
  @override
  _SStackState createState() => _SStackState();
}

class _SStackState extends State<SStack> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SList extends StatefulWidget {
  @override
  _SListState createState() => _SListState();
}

class _SListState extends State<SList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TextSelection extends StatefulWidget {
  TextSelection({Key key}) : super(key: key);
  @override
  TextSelectionState createState() => TextSelectionState();
}

class TextSelectionState extends State<TextSelection> with SelectionMixin {
  KeyHolder _holder = KeyHolder(6);

  @override
  void initState() {
    super.initState();
    //FlexineDatabase.of(context).init();
  }

  @override
  void dispose() {
    super.dispose();
    //FlexineDatabase.of(context).close();
  }

  @override
  Widget build(BuildContext context) {
    return FlexineDatabase(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: ListView(
            children: <Widget>[
              PairWidget(
                title: 'Text',
                child: StringSelection(
                  key: _holder[0],
                  initial: 'Type Here',
                ),
              ),
              PairWidget(
                title: 'Size',
                child: NumberSelection(
                  bound: Bound(1, null),
                  key: _holder[1],
                  initial: 14,
                  stepper: 4,
                ),
              ),
              PairWidget(
                title: 'Weight',
                child: NumberSelection(
                  key: _holder[2],
                  bound: Bound(1, FontWeight.values.length),
                  stepper: 1,
                  initial: FontWeight.normal.index,
                ),
              ),
              PairWidget(
                title: 'Color',
                child: ColorSelection(
                  key: _holder[3],
                  initial: Colors.black,
                ),
              ),
              PairWidget(
                title: 'Style',
                child: EnumSelection(
                  key: _holder[4],
                  pairs: ['Fill', 'Stroke'],
                ),
              ),
              PairWidget(
                title: 'StrokeWidth',
                child: NumberSelection(
                  stepper: 1,
                  bound: Bound(1, null),
                  key: _holder[5],
                  initial: 1,
                ),
              ),
              FlatButton(onPressed: _submit, child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    FlexineDatabase.of(context).init();
    FlexineDatabase.of(context).insert(flexine);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Example()));
  }

  @override
  Flexine get flexine {
    _holder.submit();
    return FText(
      text: _holder.get(0),
      fontSize: _holder.get(1).toDouble(),
      fontWeight: _holder.get(2) - 1,
      paint: FPaint(
        strokeWidth: _holder.get(5).toDouble(),
        style: _holder.get(4),
        color: _holder.get(3),
      ),
    );
  }
}

class ImageSelection extends StatefulWidget {
  @override
  _ImageSelectionState createState() => _ImageSelectionState();
}

class _ImageSelectionState extends State<ImageSelection> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ProgressSelection extends StatefulWidget {
  @override
  _ProgressSelectionState createState() => _ProgressSelectionState();
}

class _ProgressSelectionState extends State<ProgressSelection> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AlignSelection extends StatefulWidget {
  @override
  _AlignSelectionState createState() => _AlignSelectionState();
}

class _AlignSelectionState extends State<AlignSelection> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FormulaSelection extends StatefulWidget {
  @override
  _FormulaSelectionState createState() => _FormulaSelectionState();
}

class _FormulaSelectionState extends State<FormulaSelection> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class InsetSelection extends StatefulWidget {
  @override
  _InsetSelectionState createState() => _InsetSelectionState();
}

class _InsetSelectionState extends State<InsetSelection> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PaintingSelection extends StatefulWidget {
  @override
  _PaintingSelectionState createState() => _PaintingSelectionState();
}

class _PaintingSelectionState extends State<PaintingSelection> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'dart:io';

import 'package:flurine_launcher/flexine/formulas/formula.dart';
import 'package:flurine_launcher/flexine/models/actions.dart';
import 'package:flurine_launcher/flexine/models/common.dart';
import 'package:flurine_launcher/flexine/models/styling.dart';
import 'package:flurine_launcher/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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

class FText extends Flexine {
  final String text;
  final double fontSize;
  final FPaint paint;
  final int fontWeight;
  final int letterSpacing;
  final int wordSpacing;

  FText({
    this.fontWeight,
    this.paint,
    this.text,
    this.fontSize,
    this.letterSpacing,
    this.wordSpacing,
  }) : super('text');

  factory FText.fromJson(Map<String, dynamic> data) => FText(
        text: data['text'],
        fontSize: data['fontSize'],
        paint: FPaint.fromJson(data['paint']),
        fontWeight: data['fontWeight'],
        letterSpacing: data['letterSpacing'],
        wordSpacing: data['wordSpacing'],
      );

  @override
  Text toFlexible() => Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          foreground: paint.toStyle(),
          fontWeight: FontWeight.values[fontWeight],
          letterSpacing: letterSpacing.toDouble(),
          wordSpacing: wordSpacing.toDouble(),
        ),
      );

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'text': text,
        'fontSize': fontSize,
        'fontWeight': fontWeight,
        'foreground': paint,
        'letterSpacing': letterSpacing,
        'wordSpacing': wordSpacing,
      };
}

class FContainer extends Flexine {
  final Flexine child;
  final FBoxDecoration decoration;

  final FInset padding;

  final double width;

  final double height;

  final FInset margin;

  FContainer({
    this.child,
    this.decoration,
    this.padding,
    this.width,
    this.height,
    this.margin,
  }) : super('container');

  factory FContainer.fromJson(Map<String, dynamic> data) => FContainer(
        child: Flexine.fromJson(data['child']),
        decoration: FBoxDecoration.fromJson(data['decoration']),
        padding: FInset.fromJson(data['padding']),
        width: data['width'],
        height: data['height'],
        margin: FInset.fromJson(data['margin']),
      );

  @override
  Container toFlexible() => Container(
        child: child.toFlexible(),
        decoration: decoration.toStyle(),
        padding: padding.toStyle(),
        width: width,
        height: height,
        margin: margin.toStyle(),
      );

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'child': child.toJson(),
        'decoration': decoration.toJson(),
        'padding': padding.toJson(),
        'width': width,
        'height': height,
        'margin': margin.toJson(),
      };
}

class FStack extends Flexine {
  final List<Flexine> children;

  FStack({this.children}) : super('stack');

  factory FStack.fromJson(Map<String, dynamic> data) => FStack(
        children: data['children'].map((d) => Flexine.fromJson(d)),
      );

  @override
  Stack toFlexible() {
    var children =
        this.children.map((Flexine child) => child.toFlexible()).toList();
    return Stack(
      children: children,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'children': children.map((f) => f.toJson()).toList(),
      };
}

class FAlign extends Flexine {
  final Flexine child;
  final FAlignment alignment;

  FAlign({this.alignment, this.child}) : super('align');

  factory FAlign.fromJson(Map<String, dynamic> data) => FAlign(
        child: Flexine.fromJson(data['child']),
        alignment: FAlignment.fromJson(data['alignment']),
      );

  @override
  Align toFlexible() {
    return Align(
      child: child.toFlexible(),
      alignment: alignment.toStyle(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'child': child.toJson(),
        'alignment': alignment.toJson(),
      };
}

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

class FImage extends Flexine {
  final String path;
  final String url;
  final int fit;
  final double width;
  final double height;
  final double scale;

  FImage({this.fit, this.width, this.height, this.scale, this.path, this.url})
      : super('image');

  factory FImage.fromJson(Map<String, dynamic> data) => FImage(
        fit: data['fit'],
        width: data['width'],
        height: data['height'],
        scale: data['scale'],
        path: data['path'],
        url: data['url'],
      );

  @override
  toFlexible() {
    return path == null
        ? Image.network(
            url,
            fit: BoxFit.values[fit],
            width: width,
            height: height,
            scale: scale,
          )
        : Image.file(
            File(path),
            fit: BoxFit.values[fit],
            width: width,
            height: height,
            scale: scale,
          );
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'url': url,
        'path': path,
        'fit': fit,
        'width': width,
        'height': height,
        'scale': scale,
      };
}

class FProgress extends Flexine {
  final int progressType;
  final int foregroundColor;
  final int backgroundColor;
  final double value;
  final double strokeWidth;

  FProgress(
      {this.progressType,
      this.strokeWidth,
      this.foregroundColor,
      this.backgroundColor,
      this.value})
      : super('progress');

  factory FProgress.fromJson(Map<String, dynamic> data) => FProgress(
        progressType: data['progressType'],
        strokeWidth: data['strokeWidth'],
        backgroundColor: data['backgroundColor'],
        foregroundColor: data['foregroundColor'],
        value: data['value'],
      );

  @override
  ProgressIndicator toFlexible() {
    return progressType == 0
        ? LinearProgressIndicator(
            backgroundColor: Color(backgroundColor),
            valueColor: AlwaysStoppedAnimation<Color>(Color(foregroundColor)),
            value: value,
          )
        : CircularProgressIndicator(
            backgroundColor: Color(backgroundColor),
            valueColor: AlwaysStoppedAnimation<Color>(Color(foregroundColor)),
            value: value,
            strokeWidth: strokeWidth,
          );
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'progressType': progressType,
        'strokeWidth': strokeWidth,
        'backgroundColor': backgroundColor,
        'foregroundColor': foregroundColor,
        'value': value,
      };
}

class FGestureDetector extends Flexine {
  final Flexine child;
  final Actions actions;

  FGestureDetector({this.child, this.actions}) : super('gesture');

  @override
  Widget toFlexible() {
    return actions != null
        ? GS(
            child: child,
            actions: actions,
          )
        : child.toFlexible();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return null;
  }
}

class GS extends StatelessWidget {
  final Flexine child;
  final Actions actions;

  GS({this.child, this.actions});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child.toFlexible(),
      onTap: actions['onTap'](context),
    );
  }
}

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
    // TODO: implement toJson
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
            : Empty();
      },
    );
  }
}

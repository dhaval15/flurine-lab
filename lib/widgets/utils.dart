import 'package:flutter/material.dart';

class Div extends StatelessWidget {
  final double height;

  const Div({this.height = 12.0});

  @override
  Widget build(BuildContext context) => SizedBox(height: height);

  Div operator *(double scale) => Div(height: height * scale);

  Div operator /(double scale) => Div(height: height / scale);
}

class Span extends StatelessWidget {
  final double width;

  const Span({this.width = 8.0});

  @override
  Widget build(BuildContext context) => SizedBox(width: width);

  Span operator *(double scale) => Span(width: width * scale);

  Span operator /(double scale) => Span(width: width / scale);
}

class Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}

class If extends StatelessWidget {
  final bool flag;
  final Widget child;

  const If({Key key, @required this.flag, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return flag ? child : SizedBox();
  }
}

class IfStreamBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final AsyncWidgetBuilder<T> builder;
  final Widget child;

  const IfStreamBuilder(
      {Key key,
      @required this.stream,
      @required this.builder,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return stream == null
        ? child
        : StreamBuilder<T>(
            builder: builder,
            stream: stream,
          );
  }
}

class IfFutureBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final AsyncWidgetBuilder<T> builder;
  final Widget child;

  const IfFutureBuilder(
      {Key key,
      @required this.stream,
      @required this.builder,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return stream == null
        ? child
        : StreamBuilder<T>(
            builder: builder,
            stream: stream,
          );
  }
}

class Test extends StatelessWidget {
  final Widget child;

  const Test({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

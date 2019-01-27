import '../../commons/flexine.dart';
import 'package:flutter/material.dart';
import '../framework.dart';

class WidgetBloc {}

class WidgetProvider extends InheritedWidget {
  final WidgetBloc bloc;

  WidgetProvider({this.bloc, Widget child}) : super(child: child);

  factory WidgetProvider.of(BuildContext context) =>
      context.ancestorWidgetOfExactType(WidgetProvider);

  WidgetBloc call() => bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class SelectWidget extends StatelessWidget {
  //Think Better Approach
  // Move Up The Tree -> Inherited Widget
  final Sink<Flexine> sink;

  const SelectWidget(this.sink);

  @override
  Widget build(BuildContext context) {
    return WidgetProvider(
      bloc: WidgetBloc(),
      child: SimpleDialog(
        title: Text('Choose Widget'),
        children: <Widget>[
          ListView.builder(
            itemCount: WidgetFactory.length,
            itemBuilder: (BuildContext context, int index) {
              var factory = WidgetFactory.from(index);
              return GestureDetector(
                child: ListTile(title: Text(factory.title)),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => factory(sink))),
              );
            },
          ),
        ],
      ),
    );
  }
}

typedef LazyWidget = Widget Function(Sink<Flexine> sink);

class WidgetFactory {
  static final List<WidgetFactory> _list = [
    WidgetFactory(title: 'Text', delegator: (sink) => SelectText(sink)),
    WidgetFactory(
        title: 'Container', delegator: (sink) => SelectContainer(sink)),
  ];

  static int get length => _list.length;

  final String title;
  final LazyWidget delegator;

  Widget call(Sink<Flexine> sink) => delegator(sink);

  WidgetFactory({@required this.title, @required this.delegator});

  factory WidgetFactory.from(int index) => _list[index];
}

import '../../database/db.dart';
import 'package:flutter/material.dart';
import '../selection/framework.dart';
import 'editor.dart';

class SavedWidgetsBloc {
  final _db = ScreenDB();

  ScreenDB call() => _db;
}

class SavedWidgetsProvider extends InheritedWidget {
  final SavedWidgetsBloc bloc;

  SavedWidgetsProvider({this.bloc, Widget child}) : super(child: child);

  factory SavedWidgetsProvider.of(BuildContext context) =>
      context.ancestorWidgetOfExactType(SavedWidgetsProvider);

  SavedWidgetsBloc call() => bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class SavedWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = SavedWidgetsBloc();
    return SavedWidgetsProvider(
      bloc: bloc,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Center(
              child: FutureBuilder<List<FScreen>>(
                future: bloc().screens,
                builder: (BuildContext context,
                        AsyncSnapshot<List<FScreen>> snapshot) =>
                    ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        FScreen screen = snapshot.data[index];
                        return ListTile(
                          title: Text(screen.title),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Editor(screen)));
                          },
                        );
                      },
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

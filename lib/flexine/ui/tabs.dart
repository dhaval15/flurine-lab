import 'package:flutter/material.dart';

class TabLayout extends StatelessWidget {
  final List<String> titles;
  final List<Widget> children;

  const TabLayout({Key key, this.children, this.titles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: titles.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: titles.map((title) => Tab(child: Text(title))).toList(),
          ),
        ),
        body: TabBarView(children: children),
      ),
    );
  }
}

class Prefs extends StatelessWidget {
  final List<Widget> children;

  const Prefs({Key key, this.children}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: children,
    );
  }
}

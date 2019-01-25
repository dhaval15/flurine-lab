import 'dart:typed_data';

import 'package:flurine_launcher/falcon/bloc.dart';
import 'package:flurine_launcher/flexine/example.dart';
import 'package:flurine_launcher/flexine/ui/selection.dart' as selection;
import 'package:flurine_launcher/gesture/gesture_container.dart';
import 'package:flurine_launcher/plugins/apps_assist.dart';
import 'package:flurine_launcher/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Editor(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class G extends StatefulWidget {
  @override
  _GState createState() => _GState();
}

class _GState extends State<G> {
  String text = "G";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var t = Text(
      "Hello",
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          //color: Colors.red,
          foreground: Paint()
            ..color = Colors.indigo
            ..strokeWidth = 2),
    );
    setState(() {
      text = JsonEncoder((obj) {
        return obj.toString();
      }).convert(t);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureContainer(
        child: Center(
          child: Text(text),
        ),
        actions: Actions(
          onSwipeUp: () {
            setState(() {
              text = "Up";
            });
          },
          onSwipeDown: () {
            setState(() {
              text = "Down";
            });
          },
          onSwipeLeft: () {
            setState(() {
              text = "Left";
            });
          },
          onSwipeRight: () {
            setState(() {
              text = "Right";
            });
          },
        ),
      ),
    );
  }
}

class Wall extends StatefulWidget {
  @override
  WallState createState() {
    return new WallState();
  }
}

class WallState extends State<Wall> {
  Uint8List _wallpaper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initWallpaper();
  }

  void _initWallpaper() async {
    var wallpaper = await AppsAssist.getWallpaper();
    setState(() {
      _wallpaper = wallpaper;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      /*decoration: BoxDecoration(
        //color: _wallpaper == null ? null : Colors.white,
        image: _wallpaper == null
            ? null
            : DecorationImage(image: MemoryImage(_wallpaper), fit: BoxFit.fill),
      ),*/
      color: Colors.red,
      child: If(
        child: Image.memory(_wallpaper),
        flag: _wallpaper != null,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<dynamic>> _future;
  Uint8List _wallpaper;
  Stream<AppInfo> _stream;
  List<AppInfo> _apps = [];

  void _update(AppInfo info) {
    setState(() {
      _apps.add(info);
    });
  }

  @override
  void initState() {
    super.initState();
    _future = AppsAssist.getAllApps();
    _initWallpaper();
    _stream = AppsAssist.getStream();
    _stream.listen(_update);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          //color: _wallpaper == null ? null : Colors.white,
          image: _wallpaper == null
              ? null
              : DecorationImage(
                  image: MemoryImage(_wallpaper), fit: BoxFit.fill),
        ),
        child:
            /*FutureBuilder(
          future: _future,
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            List<dynamic> apps = snapshot.data;
            return If(
              child: GridView.builder(
                itemCount: apps.length,
                itemBuilder: (BuildContext context, int index) {
                  AppInfo info = AppInfo.fromJson(apps[index]);
                  return GestureDetector(
                    onTap: () {
                      AppsAssist.launchApp(info.package);
                    },
                    child: GridTile(
                      footer: Center(
                        child: Text(
                          info.label,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      child: Center(
                          child: Image.memory(
                        info.icon,
                        width: 36,
                        height: 36,
                      )),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
              ),
              flag: snapshot.hasData,
            );
          },
        ),*/
            GridView.builder(
          itemCount: _apps.length,
          itemBuilder: (BuildContext context, int index) {
            AppInfo info = _apps[index];
            return GestureDetector(
              onTap: () {
                AppsAssist.launchApp(info.package);
              },
              child: GridTile(
                footer: Center(
                  child: Text(
                    info.label,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                child: Center(
                    child: Image.memory(
                  info.icon,
                  width: 36,
                  height: 36,
                )),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
        ),
      ),
    );
  }

  void _initWallpaper() async {
    var wallpaper = await AppsAssist.getWallpaper();
    setState(() {
      _wallpaper = wallpaper;
    });
  }
}

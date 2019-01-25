import 'dart:typed_data';

import 'package:flutter/services.dart';

class AppsAssist {
  static const MethodChannel _channel =
      const MethodChannel('com.flurine.apps_assist');

  static const EventChannel _stream =
      const EventChannel('com.flurine.apps_stream');

  static Future<List<dynamic>> getAllApps() async {
    var data = await _channel.invokeMethod('getAllApps');
    return data;
  }

  static Stream<AppInfo> getStream() {
    return _stream.receiveBroadcastStream().map((result) {
      return AppInfo.fromJson(result);
    });
  }

  static launchApp(String packageName) {
    _channel.invokeMethod("launchApp", {"packageName": packageName});
  }

  static Future<Uint8List> getWallpaper() async {
    var data = await _channel.invokeMethod('getWallpaper');
    return data;
  }
}

class AppInfo {
  Uint8List icon;
  String package;
  String label;

  AppInfo({this.icon, this.label, this.package});

  factory AppInfo.fromJson(dynamic json) => AppInfo(
        label: json['label'],
        icon: json['icon'],
        package: json['package'],
      );
}

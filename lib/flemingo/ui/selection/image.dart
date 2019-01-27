import 'dart:io';

import 'package:flutter/material.dart';
import '../commons/flexine.dart';

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

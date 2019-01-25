import 'dart:async';

import 'package:flurine_launcher/flexine/models/widgets.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

@immutable
abstract class Flexine {
  final String type;

  Flexine(this.type);

  Map<String, dynamic> toJson();

  Widget toFlexible();

  factory Flexine.fromJson(Map<String, dynamic> data) {
    String type = data['type'];
    switch (type) {
      case 'screen':
        return FScreen.fromJson(data);
      case 'text':
        return FText.fromJson(data);
      case 'container':
        return FContainer.fromJson(data);
      case 'stack':
        return FStack.fromJson(data);
      case 'list':
        return FList.fromJson(data);
      case 'image':
        return FImage.fromJson(data);
      case 'align':
        return FAlign.fromJson(data);
      case 'progress':
        return FProgress.fromJson(data);
      case 'streambuilder':
        return FStreamBuilder.fromJson(data);
    }
    return null;
  }
}

Stream combine(LinkedHashMap<String, Stream> streams) => null;

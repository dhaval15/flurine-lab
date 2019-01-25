import 'package:flutter/material.dart';
import 'package:flurine_launcher/flexine/ui/ui.dart';

class KeyHolder {
  KeyHolder(int length) {
    _keys = List(length);
    for (int i = 0; i < length; i++) {
      _keys[i] = GlobalKey();
    }
  }
  List _values;

  void submit() {
    _values = _keys.map((key) => getValueFromMixinKey(key)).toList();
  }

  List<GlobalKey> _keys;

  GlobalKey operator [](int index) => _keys[index];

  get(int index) => _values[index];
}

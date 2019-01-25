import 'package:flutter/material.dart';

typedef ActionCallback = Function(BuildContext context);

abstract class Action {
  ActionCallback toFlexible();
}

class Actions {
  Map<String, Action> _actions;

  ActionCallback operator [](String key) {
    return _actions[key].toFlexible();
  }
}

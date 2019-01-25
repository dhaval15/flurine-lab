import 'dart:async';

class Formula {
  final List<dynamic> params;
  final String type;

  Formula({this.params, this.type});

  factory Formula.fromJson(Map<String, dynamic> data) => Formula(
        type: data['type'],
        params: data['params'].map((d) {
          if (d['type'] == null)
            return d;
          else
            return Formula.fromJson(d);
        }),
      );

  dynamic decode() {}

  dynamic _text() {}

  _date() {}

  _time() {}

  dynamic _music() {}

  dynamic _system() {}

  dynamic _weather() {}

  dynamic _notifications() {}

  dynamic _globals() {}

  Map<String, dynamic> toJson() => {'type': type.toString(), 'params': params};
}

import 'package:flurine_launcher/flexine/models/common.dart';
import 'package:objectdb/objectdb.dart';
import 'package:flutter/material.dart';

abstract class DataBase<T> {
  String get dbPath;

  Map encode(T object);

  T decode(Map document);

  ObjectDB _objectDb;

  Future<void> init() {
    if (_objectDb == null) _objectDb = ObjectDB(dbPath);
    return _objectDb.open();
  }

  Future<void> close() => _objectDb.close();

  Future<ObjectId> insert(T object) => _objectDb.insert(encode(object));

  Future<List<ObjectId>> insertAll(List<T> objects) =>
      _objectDb.insertMany(objects.map(encode).toList());

  Future<void> remove(Map<String, String> query) => _objectDb.remove(query);

  Future<List<T>> find(Map<String, String> query) async =>
      (await _objectDb.find(query)).map(decode).toList();

  Future first(Map<String, String> query) async =>
      decode(await _objectDb.first(query));

  Future last(Map<String, String> query) async =>
      decode(await _objectDb.last(query));
}

class FlexineDatabase extends InheritedWidget with DataBase<Flexine> {
  FlexineDatabase({Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  @override
  String get dbPath => 'flexine.db';

  factory FlexineDatabase.of(BuildContext context) =>
      context.ancestorWidgetOfExactType(FlexineDatabase);

  @override
  Flexine decode(Map document) {
    return Flexine.fromJson(document);
  }

  @override
  Map encode(Flexine object) {
    return object.toJson();
  }
}

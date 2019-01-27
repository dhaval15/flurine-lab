import 'dart:io';

import '../ui/selection/screen.dart';
import 'package:objectdb/objectdb.dart';

const DATABASE_NAME = '/flexine.db';

class ScreenDB {
  final _db = ObjectDB(Directory.current.path + DATABASE_NAME);

  ScreenDB() {
    _db.open();
  }

  Future<ObjectId> insertScreen(FScreen screen) {
    return _db.insert(screen.toJson());
  }

  Future<List<FScreen>> get screens async {
    var list = await _db.find({});
    return list.map((map) => FScreen.fromJson(map));
  }

  void close() {
    _db.close();
  }
}

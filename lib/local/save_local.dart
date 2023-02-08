
import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' as sqflite;


class SaveLocal {
  static final SaveLocal _instance = SaveLocal.internal();

  factory SaveLocal() => _instance;

  static Database _db;

  Future<Database> get db async {
    if(_db !=null) return _db;
    _db = await initDb();
    return _db;
  }

}


SaveLocal.internal();
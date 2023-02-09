import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SaveLocal {
  static final SaveLocal _instance = SaveLocal.internal();

  factory SaveLocal() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  SaveLocal.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentsDirectory.path, "daily_readings.db");
    var theDb =
        await sqflite.openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE DailyReadings(id INTEGER PRIMARY KEY, title TEXT, body TEXT)");
  }

  Future<int> addData(String title, String body) async {
    var dbClient = await db;
    int res =
        await dbClient!.insert("DailyReadings", {"title": title, "body": body});
    return res;
  }

  Future<List<Map<String, dynamic>>> getData() async {
    var dbClient = await db;
    var result = await dbClient!.query("DailyReadings");
    return result;
  }
}

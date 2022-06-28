import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LBStorage {
  static String DB = "lightboat.db";
  static int VERSION = 1;
  static String TABLE_HISTORY = "history";

  Database? _database;

  Future<int> saveHistory(String url) async {
    Database db = await database;
    return db.insert(TABLE_HISTORY, {"url": url});
  }

  Future<List<String>> queryHistories(int count) async {
    Database db = await database;
    List<Map<String, Object?>> list = await db.query(TABLE_HISTORY, limit: count);
    List<String> histories = [];
    list.forEach((element) {
      histories.add(element["url"]?.toString() ?? "");
    });
    return histories;
  }

  Future<Database> openDb() async {
    return openDatabase(join(await getDatabasesPath(), DB),
        onCreate: (db, version) {
          db.execute(createTable(TABLE_HISTORY, {"url": "TEXT"}));
        },
      version: VERSION
    );
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await openDb();
    }
    return _database!;
  }

  String createTable(String db, Map<String, String> columns) {
    String cols = "";
    columns.forEach((key, value) {
      cols += "$key $value,";
    });
    cols = cols.substring(0, cols.length - 1);
    return "CREATE TABLE $db($cols)";
  }
}
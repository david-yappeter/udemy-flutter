import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    // await sql.deleteDatabase(path.join(dbPath, 'places.db'));
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (Database db, int version) {
        return db.execute('''
          CREATE TABLE places(
            id TEXT PRIMARY KEY,
            title TEXT,
            image TEXT,
            latitude REAL,
            longitude REAL,
            location TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final sqlDb = await DBHelper.database();

    await sqlDb.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDb = await DBHelper.database();

    return sqlDb.query(table);
  }
}

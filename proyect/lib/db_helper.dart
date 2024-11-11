import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'memorama.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE best_times(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pairs INTEGER,
            time REAL
          )
        ''');
      },
    );
  }

  Future<void> insertTime(int pairs, double time) async {
    final db = await database;
    await db.insert(
      'best_times',
      {'pairs': pairs, 'time': time},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

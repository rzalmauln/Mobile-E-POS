import 'package:e_pos/data/model/store/store.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'pos_chasier.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    const sql = '''
  CREATE TABLE store (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name BOOLEAN NOT NULL,
    username INTEGER NOT NULL,
    password TEXT NOT NULL
  );
  ''';
    await db.execute(sql);
  }

  Future<void> insertStore(Store store) async {
    final db = await database;
    await db.insert('store', store.toJson());
  }

  Future<List<Store>> getStores() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('store');

    return List.generate(maps.length, (i) {
      return Store.fromJson(maps[i]);
    });
  }

  Future<void> updateStore(Store store) async {
    final db = await database;
    await db.update(
      'store',
      store.toJson(),
      where: 'id = ?',
      whereArgs: [store.id],
    );
  }

  Future<void> deleteStore(int id) async {
    final db = await database;
    await db.delete(
      'store',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

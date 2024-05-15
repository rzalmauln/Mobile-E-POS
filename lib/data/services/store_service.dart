import 'package:sqflite/sqflite.dart';
import '../model/store/store.dart';
import 'helper/database_helper.dart';

class StoreService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertStore(Store store) async {
    final db = await _databaseHelper.database;
    await db.insert('store', store.toJson());
  }

  Future<List<Store>> getStores() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('store');

    return List.generate(maps.length, (i) {
      return Store.fromJson(maps[i]);
    });
  }

  Future<void> updateStore(Store store) async {
    final db = await _databaseHelper.database;
    await db.update(
      'store',
      store.toJson(),
      where: 'id = ?',
      whereArgs: [store.id],
    );
  }

  Future<void> deleteStore(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'store',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

import 'package:sqflite/sqflite.dart';
import '../model/store/store.dart';
import '../helper/database_helper.dart';

class StoreService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertStore(Store store) async {
    final db = await _databaseHelper.database;
    await db.insert('stores', store.toJson());
  }

  Future<List<Store>>? getStores() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('stores');

    return List.generate(maps.length, (i) {
      return Store.fromJson(maps[i]);
    });
  }

  Future<Store> getStore(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('stores', where: 'id = ?', whereArgs: [id]);
    return Store.fromJson(maps.first);
  }

  Future<int> getLastIdStore() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'stores',
      orderBy: 'id DESC',
      limit: 1,
    );
    return Store.fromJson(maps.first).id;
  }

  Future<void> updateStore(Store store) async {
    final db = await _databaseHelper.database;
    await db.update(
      'stores',
      store.toJson(),
      where: 'id = ?',
      whereArgs: [store.id],
    );
  }

  Future<void> deleteStore(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'stores',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

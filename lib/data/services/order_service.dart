import 'package:sqflite/sqflite.dart';
import '../../data/model/order/order.dart';
import '../helper/database_helper.dart';

class OrderService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertOrder(Order order) async {
    final db = await _databaseHelper.database;
    await db.insert('order', order.toJson());
  }

  Future<List<Order>> getOrders() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('order');

    return List.generate(maps.length, (i) {
      return Order.fromJson(maps[i]);
    });
  }

  Future<Order> getOrder(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('order', where: 'id = ?', whereArgs: [id]);
    return Order.fromJson(maps.first);
  }

  Future<List<Order>> getOrdersByStoreId(int storeId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'order',
      where: 'store_id = ?',
      whereArgs: [storeId],
    );
    return List.generate(maps.length, (i) {
      return Order.fromJson(maps[i]);
    });
  }

  Future<void> updateOrder(Order order) async {
    final db = await _databaseHelper.database;
    await db.update(
      'order',
      order.toJson(),
      where: 'id = ?',
      whereArgs: [order.id],
    );
  }

  Future<void> deleteOrder(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'order',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

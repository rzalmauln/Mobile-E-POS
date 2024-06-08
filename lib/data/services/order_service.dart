import '../../data/model/order/order.dart';
import '../helper/database_helper.dart';

class OrderService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertOrder(int storeId, int total, DateTime orderDate) async {
    final db = await _databaseHelper.database;
    try {
      await db.insert('orders', {
        'store_id': storeId,
        'total': total,
        'order_date': orderDate.toIso8601String()
      });
    } catch (e) {
      throw Exception('Add Order failed: ${e.toString()}');
    }
  }

  Future<int> getLastIdOrder() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'orders',
      orderBy: 'id DESC',
      limit: 1,
    );
    return Order.fromJson(maps.first).id;
  }

  Future<List<Order>> getOrders() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('orders');
    return List.generate(maps.length, (i) {
      return Order.fromJson(maps[i]);
    });
  }

  Future<Order> getOrder(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('orders', where: 'id = ?', whereArgs: [id]);

    return Order.fromJson(maps.first);
  }

  Future<List<Order>> getOrdersByStoreId(int storeId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'orders',
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
      'orders',
      order.toJson(),
      where: 'id = ?',
      whereArgs: [order.id],
    );
  }

  Future<void> deleteOrder(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

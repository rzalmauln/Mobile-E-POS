import '../../data/model/order_detail/order_detail.dart';
import '../helper/database_helper.dart';

class OrderDetailService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertOrderDetail(
      int orderId, int productId, int qty, int price) async {
    final db = await _databaseHelper.database;
    try {
      db.insert('order_details', {
        'order_id': orderId,
        'product_id': productId,
        'qty': qty,
        'price': price
      });
    } catch (e) {
      throw Exception('Add Order detail failed: ${e.toString()}');
    }
  }

  Future<List<OrderDetail>> getOrderDetails() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('order_details');

    return List.generate(maps.length, (i) {
      return OrderDetail.fromJson(maps[i]);
    });
  }

  Future<OrderDetail> getOrderDetail(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('order_details', where: 'id = ?', whereArgs: [id]);
    return OrderDetail.fromJson(maps.first);
  }

  Future<List<OrderDetail>> getOrderDetailsByOrderId(int orderId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'order_details',
      where: 'order_id = ?',
      whereArgs: [orderId],
    );
    return List.generate(maps.length, (i) {
      return OrderDetail.fromJson(maps[i]);
    });
  }

  Future<void> updateOrderDetail(OrderDetail orderDetail) async {
    final db = await _databaseHelper.database;
    await db.update(
      'order_details',
      orderDetail.toJson(),
      where: 'id = ?',
      whereArgs: [orderDetail.id],
    );
  }

  Future<void> deleteOrderDetail(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'order_details',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

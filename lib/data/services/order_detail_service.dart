import 'package:sqflite/sqflite.dart';
import '../../data/model/order_detail/order_detail.dart';
import '../helper/database_helper.dart';

class OrderDetailService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertOrder(OrderDetail orderDetail) async {
    final db = await _databaseHelper.database;
    await db.insert('order_detail', orderDetail.toJson());
  }

  Future<List<OrderDetail>> getOrderDetails() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('order_detail');

    return List.generate(maps.length, (i) {
      return OrderDetail.fromJson(maps[i]);
    });
  }

  Future<OrderDetail> getOrderDetail(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('order_detail', where: 'id = ?', whereArgs: [id]);
    return OrderDetail.fromJson(maps.first);
  }

  Future<List<OrderDetail>> getOrderDetailsByOrderId(int orderId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'order_detail',
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
      'order_detail',
      orderDetail.toJson(),
      where: 'id = ?',
      whereArgs: [orderDetail.id],
    );
  }

  Future<void> deleteOrderDetail(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'order_detail',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

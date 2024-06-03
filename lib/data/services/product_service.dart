import '../../data/model/product/product.dart';
import '../helper/database_helper.dart';

class ProductService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertProduct(String name, int stock, int price) async {
    final db = await _databaseHelper.database;
    try {
      await db
          .insert('product', {'name': name, 'stock': stock, 'price': price});
    } catch (e) {
      throw Exception('Register failed: ${e.toString()}');
    }
  }

  Future<List<Product>> getProducts() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('product');

    return List.generate(maps.length, (i) {
      return Product.fromJson(maps[i]);
    });
  }

  Future<Product> getProduct(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('product', where: 'id = ?', whereArgs: [id]);
    return Product.fromJson(maps.first);
  }

  Future<void> updateProduct(Product product) async {
    final db = await _databaseHelper.database;
    await db.update(
      'product',
      product.toJson(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> deleteProduct(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'product',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

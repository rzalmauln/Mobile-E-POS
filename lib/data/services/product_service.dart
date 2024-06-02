import '../../data/model/product/product.dart';
import '../helper/database_helper.dart';

class ProductService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertProduct(Product product) async {
    final db = await _databaseHelper.database;
    await db.insert('product', product.toJson());
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

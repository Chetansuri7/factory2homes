import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'cartitem.db'),
        onCreate: (db, version) {
      db.execute("CREATE TABLE cart("
          "id INTEGER PRIMARY KEY, "
          "productId INTEGER, "
          "productName TEXT, "
          "productListPrice INTEGER, "
          "productSalePrice INTEGER, "
          "productDiscount TEXT, "
          "productTax TEXT, "
          "productPhoto TEXT, "


          "productSku TEXT, "
          "quantity INTEGER)");
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data,conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  static Future<List<Map<String, dynamic>>> getCartData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}

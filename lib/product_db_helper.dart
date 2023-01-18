import 'dart:async';
import 'dart:io';

import 'package:database_app/product.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ProductDBHelper {

  static final _databaseName = 'mydb.db';
  static final _databaseVersion = 1;

  static final _table_products = 'products';
  static String ? path;

  ProductDBHelper._privateConstructor();

  static final ProductDBHelper instance = ProductDBHelper._privateConstructor();

  static Database ? _database;

  // ======== Check whether the database created or not ============
  Future get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  // ======= Initialize database with local file path, db name =========
  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    // ===== LocalStorage path/databasename.db
    String path = join(documentDirectory.path, _databaseName);

    return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate
    );
  }

 // ======= On create for creating database ============
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_table_products(id INTEGER PRIMARY KEY autoincrement, name TEXT , price TEXT , quantity INTEGER)');
  }

  static Future getFileData() async{
    return getDatabasesPath().then((value){
      return path = value;
    });
  }

  Future insertProduct(Product product)async{
    Database db = await instance.database;
    return await db.insert(_table_products, Product.toMap(product), conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Product>> getProductList() async {
    Database db = await instance.database;
    List<Map> maps = await db.query(_table_products);
    print(maps);
    return Product.fromMapList(maps);
  }

  Future<Product> updateProduct(Product product) async{
    Database db = await instance.database;

    await db.update(_table_products, Product.toMap(product), where: 'id= ?',
        whereArgs: [product.id]);

    return product;
  }

  Future deleteProduct(Product product) async{
    Database db = await instance.database;

    var deleteProduct = db.delete(_table_products, where: 'id= ?',
        whereArgs: [product.id]);

    return deleteProduct;
  }

}
import 'dart:core';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:week8/core/constants/db_constants.dart';
import 'package:week8/models/cart.dart';
import 'package:week8/models/favorite.dart';
import 'package:week8/models/order_item.dart';
import 'package:week8/models/user.dart';

class DatabaseService {
  static const int dbVersion = 4;
  static const String dbName = 'food_delivery_apps.db';
  Database? _database;
  // DATABASE GETTER
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // INIT DATABASE
  Future<Database> _initDB() async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, dbName);

    return openDatabase(
      path,
      version: dbVersion,
      onCreate: _onCreate,
    );
  }

  // CREATE TABLES
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${DBTables.user}(
      ${UserColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${UserColumns.name} TEXT,
      ${UserColumns.password} TEXT,
      ${UserColumns.email} TEXT
    );
  ''');

    await db.execute('''
    CREATE TABLE ${DBTables.cart}(
      ${CartColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${CartColumns.mealId} TEXT,
      ${CartColumns.mealName} TEXT,
      ${CartColumns.mealImage} TEXT,
      ${CartColumns.price} REAL,
      ${CartColumns.quantity} INTEGER
    );
  ''');

    await db.execute('''
    CREATE TABLE ${DBTables.orderItems}(
      ${OrderItemColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${OrderItemColumns.mealId} TEXT,
      ${OrderItemColumns.mealName} TEXT,
      ${OrderItemColumns.mealImage} TEXT,
      ${OrderItemColumns.price} REAL,
      ${OrderItemColumns.quantity} INTEGER,
      ${OrderItemColumns.status} TEXT
    );
  ''');

    await db.execute('''
    CREATE TABLE ${DBTables.favorites}(
      ${FavoriteColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${FavoriteColumns.mealId} TEXT UNIQUE,
      ${FavoriteColumns.mealName} TEXT,
      ${FavoriteColumns.mealImage} TEXT
    );
  ''');
  }

  // get all the cart items
  Future<List<Map<String, dynamic>>> getCart() async {
    final db = await database;
    return await db.query(DBTables.cart);
  }

  Future<List<Map<String, dynamic>>> getOrdereItem() async {
    final db = await database;
    return await db.query(DBTables.orderItems);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.query(DBTables.favorites);
  }

  Future<int> insertCart(CartItem item) async {
    final db = await database;
    return db.insert(DBTables.cart, item.toMap());
  }

  Future<int> insertOrderItem(OrderItem data) async {
    final db = await database;
    final insertData = data.toMap();
    return db.insert(DBTables.orderItems, insertData);
  }

  Future<int> insertFavorite(Favorite data) async {
    final db = await database;
    final insertData = data.toMap();
    return db.insert(DBTables.favorites, insertData);
  }

  Future<int> insertUsers(User data) async {
    final db = await database;
    final insertData = data.toMap();
    return db.insert(DBTables.user, insertData);
  }

  Future<int> deleteOrderItem(int id) async {
    final db = await database;
    return await db.delete(
      DBTables.orderItems,
      where: '${OrderItemColumns.id} = ?',
      whereArgs: [id],
    );
  }
}

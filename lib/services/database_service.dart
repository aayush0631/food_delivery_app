import 'dart:core';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:week8/core/constants/db_constants.dart';
import 'package:week8/models/cart.dart';
import 'package:week8/models/favorite.dart';
import 'package:week8/models/order.dart';
import 'package:week8/models/order_item.dart';
import 'package:week8/models/user.dart';

class DatabaseService {
  static const int dbVersion = 1;
  static const String dbName = 'food_delivery_app.db';
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
      CREATE TABLE $DBTables.tableUser(
        $UserColumns.colUserId INTEGER PRIMARY KEY AUTOINCREMENT,
        $UserColumns.colUserName TEXT,
        $UserColumns.colUserPassword TEXT,
        $UserColumns.colUserEmail TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE $DBTables.tableCart(
        $CartColumns.colCartId INTEGER PRIMARY KEY AUTOINCREMENT,
        $CartColumns.colCartMealId TEXT,
        $CartColumns.colCartMealName TEXT,
        $CartColumns.colCartMealImage TEXT,
        $CartColumns.colCartPrice REAL,
        $CartColumns.colCartQuantity INTEGER
      );
    ''');
    await db.execute('''
      CREATE TABLE $DBTables.tableOrders(
        $OrderColumns.colOrderId INTEGER PRIMARY KEY AUTOINCREMENT,
        $OrderColumns.colOrderUserId INTEGER,
        $OrderColumns.colOrderTotalAmount REAL,
        $OrderColumns.colOrderStatus TEXT,
        $OrderColumns.colOrderCreatedAt TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE $DBTables.tableOrderItems(
        $OrderItemColumns.colOrderItemId INTEGER PRIMARY KEY AUTOINCREMENT,
        $OrderItemColumns.colOrderItemOrderId INTEGER,
        $OrderItemColumns.colOrderItemMealId TEXT,
        $OrderItemColumns.colOrderItemMealName TEXT,
        $OrderItemColumns.colOrderItemMealImage TEXT,
        $OrderItemColumns.colOrderItemPrice REAL,
        $OrderItemColumns.colOrderItemQuantity INTEGER
      );
    ''');
    await db.execute('''
      CREATE TABLE $DBTables.tableFavorites(
        $FavoriteColumns.colFavId INTEGER PRIMARY KEY AUTOINCREMENT,
        $FavoriteColumns.colFavMealId TEXT UNIQUE,
        $FavoriteColumns.colFavMealName TEXT,
        $FavoriteColumns.colFavMealImage TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE $DBTables.tableDelivery(
        $DeliveryColumns.colDeliveryId INTEGER PRIMARY KEY AUTOINCREMENT,
        $DeliveryColumns.colDeliveryOrderId INTEGER,
        $DeliveryColumns.colDeliveryLatitude REAL,
        $DeliveryColumns.colDeliveryLongitude REAL,
        $DeliveryColumns.colDeliveryStatus TEXT
      );
    ''');
  }

  // get all the cart items
  Future<List<Map<String, dynamic>>> getCart() async {
    final db = await database;
    return await db.query(DBTables.cart);
  }

  Future<List<Map<String, dynamic>>> getOrder() async {
    final db = await database;
    return await db.query(DBTables.orders);
  }

  Future<List<Map<String, dynamic>>> getOrdereItem() async {
    final db = await database;
    return await db.query(DBTables.orderItems);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.query(DBTables.favorites);
  }

  Future<List<Map<String, dynamic>>> getDelivery() async {
    final db = await database;
    return await db.query(DBTables.delivery);
  }

  Future<int> insertCart(CartItem item) async {
    final db = await database;
    return db.insert(DBTables.cart, item.toMap());
  }

  Future<int> insertOrders(Order data) async {
    final db = await database;
    final insertData = data.toMap();
    return db.insert(DBTables.orders, insertData);
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
}

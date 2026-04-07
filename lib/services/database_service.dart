import 'dart:core';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? _database;
  static const int dbVersion = 1;
  static const String dbName = 'food_delivery_app';
  static const String userId = 'useris';
  static const String userName = 'name';
  static const String email = 'email';
  static const String password = 'password';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, dbName);

    return openDatabase(
      path,
      version: dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE user(
            $userId INTEGER PRIMARY KEY AUTOINCREMENT,
            $userName  TEXT,
            $password TEXT,
            $email TEXT
        );
    ''');
    await db.execute('''
        CREATE TABLE cart (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            meal_id TEXT,
            meal_name TEXT,
            meal_image TEXT,
            price REAL,
            quantity INTEGER
        );
    ''');
    await db.execute('''
        CREATE TABLE orders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            total_amount REAL,
            status TEXT,
            created_at TEXT
        );
    ''');
    await db.execute('''
        CREATE TABLE order_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            order_id INTEGER,
            meal_id TEXT,
            meal_name TEXT,
            meal_image TEXT,
            price REAL,
            quantity INTEGER
        );
    ''');
    await db.execute('''
        CREATE TABLE favorites (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            meal_id TEXT UNIQUE,
            meal_name TEXT,
            meal_image TEXT
        );
    ''');
  }
}

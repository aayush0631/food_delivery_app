import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {}

// class DatabaseService {
//   Database? _database;
//   static const int dbVersion=1;
//   static const String dbName='food_delivery_app';


//   Future<Database> get database() async {
//     if(_database==null){
//       _database=await _initDB();
//     }else{
//       return _database!;
//     }

//   }

//   future<Database> initDB() async{
//     final dbpath = await getDatabasesPath();
//     final path = await join(dbpath,dbName);

//     return openDatabase(
//       path,
//       onCreate: (db, version) => ,
//     )
//   }
// }

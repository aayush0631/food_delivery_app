import 'package:sqflite/sqflite.dart';

class ErrorHandling implements Exception {
  final String errorMessage;

  ErrorHandling({required this.errorMessage});

  static ErrorHandling fromDatabaseError(DatabaseException db) {
    if (db.isUniqueConstraintError()) {
      return ErrorHandling(errorMessage: "Database already exist. $db");
    } else if (db.isDatabaseClosedError()) {
      return ErrorHandling(errorMessage: "Database is already closed. $db");
    } else if (db.isDuplicateColumnError()) {
      return ErrorHandling(errorMessage: "Column already exists. $db");
    } else if (db.isNoSuchTableError()) {
      return ErrorHandling(errorMessage: "Table doesnot exists. $db");
    } else if (db.isSyntaxError()) {
      return ErrorHandling(errorMessage: "Syntax Error. $db");
    } else {
      return ErrorHandling(errorMessage: "Unknown Error. $db");
    }
  }

  @override
  String toString() {
    return errorMessage;
  }
}

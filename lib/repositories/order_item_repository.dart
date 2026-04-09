import 'package:week8/app/app.locator.dart';
import 'package:week8/models/order_item.dart';
import 'package:week8/services/database_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:week8/core/utils/db_error_handler.dart';
import 'package:week8/core/utils/results.dart';

class OrderItemRepository {
  final DatabaseService _databaseService = locator<DatabaseService>();

  Future<Results<int>> addToFavorite(OrderItem fItem) async {
    try {
      final id = await _databaseService.insertOrderItem(fItem);
      return Success(id);
    } catch (e) {
      if (e is DatabaseException) {
        return Failure(ErrorHandling.fromDatabaseError(e).toString());
      }
      return const Failure('something went wrong');
    }
  }
}

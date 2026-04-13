import 'package:week8/app/app.locator.dart';
import 'package:week8/core/constants/db_constants.dart';
import 'package:week8/models/cart.dart';
import 'package:week8/models/order_item.dart';
import 'package:week8/services/database_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:week8/core/utils/db_error_handler.dart';
import 'package:week8/core/utils/results.dart';

class OrderItemRepository {
  final DatabaseService _databaseService = locator<DatabaseService>();

  Future<Results<int>> addToOrder(CartItem cartItem) async {
    final item = OrderItem(
      mealId: cartItem.mealId,
      mealName: cartItem.mealName,
      mealImage: cartItem.mealImage,
      price: cartItem.price,
      quantity: cartItem.quantity,
      status: 'cooking',
    );

    try {
      final id = await _databaseService.insertOrderItem(item);
      return Success(id);
    } catch (e) {
      if (e is DatabaseException) {
        return Failure(ErrorHandling.fromDatabaseError(e).toString());
      }
      return const Failure('something went wrong');
    }
  }

  Future<Results<List<OrderItem>>> getOrder() async {
    try {
      final data = await _databaseService.getOrdereItem();
      final orders = data.map((e) => OrderItem.fromMap(e)).toList();
      return Success(orders);
    } catch (e) {
      if (e is DatabaseException) {
        return Failure(ErrorHandling.fromDatabaseError(e).toString());
      }
      return const Failure('something went wrong');
    }
  }

  Future<Results<bool>> deleteOrder(int id) async {
    try {
      final rowsDeleted = await _databaseService.deleteOrderItem(id);
      return Success(rowsDeleted > 0);
    } catch (e) {
      if (e is DatabaseException) {
        return Failure(ErrorHandling.fromDatabaseError(e).toString());
      }
      return const Failure('Failed to delete order');
    }
  }

  Future<Results<int>> updateOrderStatus(int id, String status) async {
    try {
      final db = await _databaseService.database;

      final result = await db.update(
        DBTables.orderItems,
        {'status': status},
        where: '${OrderItemColumns.id} = ?',
        whereArgs: [id],
      );

      return Success(result);
    } catch (e) {
      if (e is DatabaseException) {
        return Failure(ErrorHandling.fromDatabaseError(e).toString());
      }
      return const Failure('Failed to update order status');
    }
  }
}

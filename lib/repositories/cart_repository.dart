import 'package:sqflite/sqflite.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/core/utils/db_error_handler.dart';
import 'package:week8/core/utils/results.dart';
import 'package:week8/models/cart.dart';
import 'package:week8/services/database_service.dart';

class CartRepository {
  final DatabaseService _databaseService = locator<DatabaseService>();

  Future<Results<List<CartItem>>> getCart() async {
    try {
      final data = await _databaseService.getCart();
      final cartItems = data.map((e) => CartItem.fromMap(e)).toList();
      return Success(cartItems);
    } catch (e) {
      if (e is DatabaseException) {
        return Failure(ErrorHandling.fromDatabaseError(e).toString());
      }
      return const Failure('something went wrong');
    }
  }

  Future<Results<int>> addToCart(CartItem cItem) async {
    try {
      final id = await _databaseService.insertCart(cItem);
      return Success(id);
    } catch (e) {
      if (e is DatabaseException) {
        return Failure(ErrorHandling.fromDatabaseError(e).toString());
      }
      return const Failure('something went wrong');
    }
  }
}

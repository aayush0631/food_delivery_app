import 'package:sqflite/sqflite.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/core/utils/db_error_handler.dart';
import 'package:week8/core/utils/results.dart';
import 'package:week8/models/favorite.dart';
import 'package:week8/services/database_service.dart';

class FavoriteRepository {
  final DatabaseService _databaseService = locator<DatabaseService>();
  Future<Results<List<Favorite>>> getFavorite() async {
    try {
      final data = await _databaseService.getFavorites();
      final favorites = data.map((e) => Favorite.fromMap(e)).toList();
      return Success(favorites);
    } catch (e) {
      if (e is DatabaseException) {
        return Failure(ErrorHandling.fromDatabaseError(e).toString());
      }
      return const Failure('something went wrong');
    }
  }

  Future<Results<int>> addToFavorite(Favorite fItem) async {
    try {
      final id = await _databaseService.insertFavorite(fItem);
      return Success(id);
    } catch (e) {
      if (e is DatabaseException) {
        return Failure(ErrorHandling.fromDatabaseError(e).toString());
      }
      return const Failure('something went wrong');
    }
  }
}

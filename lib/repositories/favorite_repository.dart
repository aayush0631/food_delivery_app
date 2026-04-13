import 'package:week8/app/app.locator.dart';
import 'package:week8/core/constants/db_constants.dart';
import 'package:week8/core/utils/results.dart';
import 'package:week8/models/favorite.dart';
import 'package:week8/models/meals.dart';
import 'package:week8/services/database_service.dart';

class FavoriteRepository {
  final DatabaseService _databaseService = locator<DatabaseService>();

  Future<Results<List<Favorite>>> getFavorite() async {
    try {
      final data = await _databaseService.getFavorites();
      final favorites = data.map((e) => Favorite.fromMap(e)).toList();
      return Success(favorites);
    } catch (e) {
      return const Failure('something went wrong');
    }
  }

  // ✅ SINGLE TOGGLE METHOD (NO MORE DUPLICATE ERROR)
  Future<Results<bool>> toggleFavorite(Meal mealItem) async {
    try {
      final db = await _databaseService.database;

      final existing = await db.query(
        DBTables.favorites,
        where: '${FavoriteColumns.mealId} = ?',
        whereArgs: [mealItem.id],
      );

      if (existing.isNotEmpty) {
        await db.delete(
          DBTables.favorites,
          where: '${FavoriteColumns.mealId} = ?',
          whereArgs: [mealItem.id],
        );
        return const Success(false); // removed
      } else {
        final item = Favorite(
          mealId: mealItem.id,
          mealName: mealItem.name,
          mealImage: mealItem.image,
        );

        await _databaseService.insertFavorite(item);
        return const Success(true);
      }
    } catch (e) {
      return const Failure('something went wrong');
    }
  }
}

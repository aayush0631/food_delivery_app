import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/app/app.router.dart';
import 'package:week8/core/utils/results.dart';
import 'package:week8/models/favorite.dart';
import 'package:week8/models/meals.dart';
import 'package:week8/repositories/favorite_repository.dart';
import 'package:week8/services/api_service.dart';
import 'package:week8/services/theme_service.dart';

class FoodMenuViewModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();
  final FavoriteRepository _favoriteRepository = locator<FavoriteRepository>();
  final ThemeService _themeService = locator<ThemeService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void toggleTheme() => _themeService.toggleTheme();
  List<Meal> _meals = [];
  List<Meal> get meals => _meals;
  Set<String> favoriteMealIds = {};
  bool get hasMeals => _meals.isNotEmpty;

  //LOAD MEALS + FAVORITES
  Future<void> fetchMeals() async {
    final result = await runBusyFuture(_apiService.getMeals());
    if (result is Success<List<Meal>>) {
      _meals = result.data;
      await loadFavorites();
    } else if (result is Failure) {
      setError((result as Failure).message);
      _meals = [];
    }
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    final result = await _favoriteRepository.getFavorite();
    if (result is Success<List<Favorite>>) {
      favoriteMealIds = result.data.map((e) => e.mealId).toSet();
      notifyListeners();
    }
  }

  // TOGGLE FAVORITE
  Future<void> addToFavorite(Meal meal) async {
    final result = await runBusyFuture(
      _favoriteRepository.toggleFavorite(meal),
    );
    if (result is Success<bool>) {
      if (result.data) {
        favoriteMealIds.add(meal.id);
      } else {
        favoriteMealIds.remove(meal.id);
      }
      notifyListeners();
    } else if (result is Failure) {
      setError((result as Failure).message);
    }
  }

  void nav() {
    _navigationService.navigateToCartView();
  }

  void openMealDescription(Meal meal) {
    _navigationService.navigateToMealDescriptionView(meal: meal);
  }
}

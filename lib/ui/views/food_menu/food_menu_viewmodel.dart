import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/app/app.router.dart';
import 'package:week8/models/favorite.dart';
import 'package:week8/models/meals.dart';
import 'package:week8/repositories/favorite_repository.dart';
import 'package:week8/services/api_service.dart';
import 'package:week8/services/theme_service.dart';

class FoodMenuViewModel extends BaseViewModel {
  FoodMenuViewModel();
  final ApiService _apiService = locator<ApiService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ThemeService _themeService = locator<ThemeService>();
  final FavoriteRepository _favoriteRepository = locator<FavoriteRepository>();
  void toggleTheme() => _themeService.toggleTheme();
  Set<String> favoriteMealIds = {};
  void toggleFavorite(Meal meal) {
    if (favoriteMealIds.contains(meal.id)) {
      favoriteMealIds.remove(meal.id);
    } else {
      favoriteMealIds.add(meal.id);
    }
    notifyListeners();
  }

  List<Meal> _meals = [];
  List<Meal> get meals => _meals;

  bool get hasMeals => _meals.isNotEmpty;

  Future<void> fetchMeals() async {
    try {
      _meals = await runBusyFuture(_apiService.getMeals());
    } catch (e) {
      _meals = [];
    }
    notifyListeners();
  }

  Future<void> addToFavorite(Meal mealItem) async {
    toggleFavorite(mealItem);
    await runBusyFuture(_favoriteRepository.addToFavorite(mealItem));
  }

  void nav() {
    _navigationService.navigateToCartView();
  }

  void openMealDescription(Meal meal) {
    _navigationService.navigateToMealDescriptionView(meal: meal);
  }
}

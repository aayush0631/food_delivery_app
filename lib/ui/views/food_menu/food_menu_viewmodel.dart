import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/app/app.router.dart';
import 'package:week8/core/utils/results.dart';
import 'package:week8/models/meals.dart';
import 'package:week8/repositories/favorite_repository.dart';
import 'package:week8/services/api_service.dart';
import 'package:week8/services/theme_service.dart';

class FoodMenuViewModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ThemeService _themeService = locator<ThemeService>();
  final FavoriteRepository _favoriteRepository = locator<FavoriteRepository>();

  void toggleTheme() => _themeService.toggleTheme();

  Set<String> favoriteMealIds = {};
  List<Meal> _meals = [];
  List<Meal> get meals => _meals;
  bool get hasMeals => _meals.isNotEmpty;

  Future<void> fetchMeals() async {
    final result = await runBusyFuture(_apiService.getMeals());
    if (result is Success<List<Meal>>) {
      _meals = result.data;
    } else if (result is Failure) {
      setError((result as Failure).message);
      _meals = [];
    }
    notifyListeners();
  }

  Future<void> addToFavorite(Meal mealItem) async {
    toggleFavorite(mealItem);
    final result = await runBusyFuture(
      _favoriteRepository.addToFavorite(mealItem),
    );
    if (result is Failure) {
      setError((result as Failure).message);
    }
  }

  void toggleFavorite(Meal meal) {
    if (favoriteMealIds.contains(meal.id)) {
      favoriteMealIds.remove(meal.id);
    } else {
      favoriteMealIds.add(meal.id);
    }
    notifyListeners();
  }

  void nav() {
    _navigationService.navigateToCartView();
  }

  void openMealDescription(Meal meal) {
    _navigationService.navigateToMealDescriptionView(meal: meal);
  }
}

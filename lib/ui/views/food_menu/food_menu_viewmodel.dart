import 'package:stacked/stacked.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/models/meals.dart';
import 'package:week8/services/api_service.dart';

class FoodMenuViewModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();

  List<Meal> _meals = [];
  List<Meal> get meals => _meals;

  bool get hasMeals => _meals.isNotEmpty;

  /// Called from View
  Future<void> fetchMeals() async {
    print(" FETCH MEALS CALLED");

    setBusy(true);

    try {
      final result = await runBusyFuture(_apiService.getMeals());

      _meals = result;

      print("✅ Meals received: ${_meals.length}");
    } catch (e) {
      print("❌ Error fetching meals: $e");
      _meals = [];
    }

    setBusy(false);
    notifyListeners();
  }
}

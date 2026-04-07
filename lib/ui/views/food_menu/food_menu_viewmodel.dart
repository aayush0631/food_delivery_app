import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import '../../../models/meals.dart';
import '../../../services/api_service.dart';

class FoodMenuViewModel extends BaseViewModel {
  final ApiService _apiService = ApiService();

  List<Meal> _meals = [];
  List<Meal> get meals => _meals;

  bool get hasMeals => _meals.isNotEmpty;

  Future<void> init() async {
    await fetchMeals();
  }

  Future fetchMeals() async {
    _meals = await runBusyFuture(_apiService.getMeals());
    notifyListeners();
  }
}

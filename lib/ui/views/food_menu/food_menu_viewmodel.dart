import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/app/app.bottomsheets.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/models/add_to_cart.dart';
import 'package:week8/models/cart.dart';
import 'package:week8/models/meals.dart';
import 'package:week8/repositories/cart_repository.dart';
import 'package:week8/services/api_service.dart';

class FoodMenuViewModel extends BaseViewModel {
  final CartRepository _cartRepository;
  FoodMenuViewModel(this._cartRepository);
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final ApiService _apiService = locator<ApiService>();

  List<Meal> _meals = [];
  List<Meal> get meals => _meals;

  bool get hasMeals => _meals.isNotEmpty;

  /// Called from View
  Future<void> fetchMeals() async {
    setBusy(true);
    try {
      final result = await runBusyFuture(_apiService.getMeals());
      _meals = result;
    } catch (e) {
      _meals = [];
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> openAddToCartSheet(Meal meal) async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addToCart,
      data: meal,
    );

    if (response?.confirmed == true) {
      final sheetData = response!.data as AddToCartSheetData;

      final item = CartItem(
        mealId: meal.id,
        mealName: meal.name,
        quantity: sheetData.quantity,
        mealImage: meal.image,
        price: 0,
      );

      await addToCart(item);
    }
  }

  Future<void> addToCart(CartItem item) async {
    setBusy(true);
    await runBusyFuture(_cartRepository.addToCart(item));
    setBusy(false);
  }
}

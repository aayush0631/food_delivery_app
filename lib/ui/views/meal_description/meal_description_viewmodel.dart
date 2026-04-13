import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/app/app.bottomsheets.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/models/add_to_cart.dart';
import 'package:week8/models/cart.dart';
import 'package:week8/models/meals.dart';
import 'package:week8/repositories/cart_repository.dart';
import 'package:week8/services/theme_service.dart';

class MealDescriptionViewModel extends BaseViewModel {
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final ThemeService _themeService = locator<ThemeService>();
  final CartRepository _cartRepository = locator<CartRepository>();
  void toggleTheme() => _themeService.toggleTheme();

  void init(Meal meal) {}

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
        price: meal.price,
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

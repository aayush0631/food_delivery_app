import 'package:week8/repositories/cart_repository.dart';
import 'package:week8/repositories/favorite_repository.dart';
import 'package:week8/repositories/order_item_repository.dart';
import 'package:week8/services/api_service.dart';
import 'package:week8/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:week8/ui/bottom_sheets/add_to_cart_sheet.dart';
import 'package:week8/ui/views/login/login_view.dart';
import 'package:week8/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/ui/views/food_menu/food_menu_view.dart';
import 'package:week8/services/theme_service.dart';
import 'package:week8/services/auth_service.dart';
import 'package:week8/services/database_service.dart';
import 'package:week8/ui/views/cart/cart_view.dart';
import 'package:week8/ui/views/meal_description/meal_description_view.dart';
import 'package:week8/ui/views/orders/orders_view.dart';
import 'package:week8/ui/views/main/main_view.dart';
import 'package:week8/ui/views/order_description/order_description_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: FoodMenuView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: CartView),
    MaterialRoute(page: MealDescriptionView),
    MaterialRoute(page: OrdersView),
    MaterialRoute(page: MainView),
    MaterialRoute(page: OrderDescriptionView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    Singleton(classType: NavigationService),
    LazySingleton(classType: ApiService),
    InitializableSingleton(classType: ThemeService),
    InitializableSingleton(classType: AuthService),
    Singleton(classType: DatabaseService),
    LazySingleton(classType: CartRepository),
    LazySingleton(classType: FavoriteRepository),
    LazySingleton(classType: OrderItemRepository)
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: AddToCartSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}

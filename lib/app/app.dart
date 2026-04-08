import 'package:week8/repositories/cart_repository.dart';
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
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: FoodMenuView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: CartView),
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

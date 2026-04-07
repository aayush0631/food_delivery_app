import 'package:stacked/stacked.dart';
import 'package:week8/services/api_service.dart';
import 'package:week8/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:week8/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:week8/ui/views/home/home_view.dart';
import 'package:week8/ui/views/login/login_view.dart';
import 'package:week8/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/ui/views/food_menu/food_menu_view.dart';
import 'package:week8/services/theme_service.dart';
import 'package:week8/services/auth_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    CustomRoute(page: HomeView, transitionsBuilder: TransitionsBuilders.fadeIn),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: FoodMenuView),
    MaterialRoute(page: LoginView)
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    Singleton(classType: NavigationService),
    LazySingleton(classType: ApiService),
    InitializableSingleton(classType: ThemeService),
    InitializableSingleton(classType: AuthService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/app/app.router.dart';
import 'package:week8/core/utils/results.dart';
import 'package:week8/models/order_item.dart';
import 'package:week8/repositories/order_item_repository.dart';
import 'package:week8/services/theme_service.dart';

class OrdersViewModel extends BaseViewModel {
  final OrderItemRepository _orderItemRepository =
      locator<OrderItemRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ThemeService _themeService = locator<ThemeService>();

  List<OrderItem> _orders = [];
  List<OrderItem> get orders => _orders;

  void toggleTheme() => _themeService.toggleTheme();

  Future<void> fetchOrderedItems() async {
    final result = await runBusyFuture(_orderItemRepository.getOrder());
    if (result is Success<List<OrderItem>>) {
      _orders = result.data;
    } else if (result is Failure) {
      setError((result as Failure).message);
      _orders = [];
    }
    notifyListeners();
  }

  Future<void> completeOrder(OrderItem order) async {
    final result = await runBusyFuture(
      _orderItemRepository.updateOrderStatus(order.id!, "completed"),
    );

    if (result is Success) {
      await _orderItemRepository.deleteOrder(order.id!);
      await fetchOrderedItems();
    } else if (result is Failure) {
      setError((result as Failure).message);
    }
  }

  void nav() {
    _navigationService.navigateToCartView();
  }

  void navigateToOrderDescription(OrderItem order) {
    _navigationService.navigateToOrderDescriptionView(order: order);
  }
}

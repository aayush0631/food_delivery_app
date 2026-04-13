import 'package:stacked/stacked.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/models/order_item.dart';
import 'package:week8/repositories/order_item_repository.dart';

class OrderDescriptionViewModel extends BaseViewModel {
  final OrderItem order;

  OrderDescriptionViewModel({required this.order});
  final OrderItemRepository _orderItemRepository =
      locator<OrderItemRepository>();

  void startCooking() async {
    await _orderItemRepository.updateOrderStatus(order.id!, "cooking");
  }
}

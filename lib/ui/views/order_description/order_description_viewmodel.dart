import 'package:stacked/stacked.dart';
import 'package:week8/models/order_item.dart';

class OrderDescriptionViewModel extends BaseViewModel {
  final OrderItem order;

  OrderDescriptionViewModel({required this.order});

  void startCooking() {
    setBusy(true);

    Future.delayed(const Duration(seconds: 1), () {
      setBusy(false);
    });
  }
}

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/core/utils/results.dart';
import 'package:week8/models/cart.dart';
import 'package:week8/repositories/cart_repository.dart';
import 'package:week8/repositories/order_item_repository.dart';

class CartViewModel extends BaseViewModel {
  final CartRepository _cartRepository = locator<CartRepository>();
  final OrderItemRepository _orderItemRepository =
      locator<OrderItemRepository>();
  final DialogService _dialogService = locator<DialogService>();

  List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;
  final List<CartItem> _selected = [];
  List<CartItem> get selectedItems => _selected;
  bool get isSelectionMode => _selected.isNotEmpty;
  bool _showSuccess = false;
  bool get showSuccess => _showSuccess;

  void resetSuccess() {
    _showSuccess = false;
  }

  void toggleStateOfSelection(CartItem cItem) {
    if (_selected.contains(cItem)) {
      _selected.remove(cItem);
    } else {
      _selected.add(cItem);
    }
    notifyListeners();
  }

  void clearSelection() {
    _selected.clear();
    notifyListeners();
  }

  Future<void> fetchCartItems() async {
    final result = await runBusyFuture(_cartRepository.getCart());

    if (result is Success<List<CartItem>>) {
      _cart = result.data;
      notifyListeners();
    } else if (result is Failure) {
      setError((result as Failure).message);
    }
  }

  Future<void> addSelectedToOrders() async {
    setBusy(true);

    try {
      for (var item in _selected) {
        final result = await _orderItemRepository.addToOrder(item);

        if (result is Failure) {
          setBusy(false);

          await _dialogService.showDialog(
            title: 'Error',
            description: (result as Failure).message,
          );

          return;
        }
      }

      clearSelection();
      setBusy(false);

      await _dialogService.showDialog(
        title: 'Success',
        description: 'Items added to orders',
      );
    } catch (e) {
      setBusy(false);

      await _dialogService.showDialog(
        title: 'Error',
        description: 'Something went wrong',
      );
    }
  }
}

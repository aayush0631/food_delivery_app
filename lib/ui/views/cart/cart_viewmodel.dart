import 'package:stacked/stacked.dart';
import 'package:week8/core/utils/results.dart';
import 'package:week8/models/cart.dart';
import 'package:week8/models/order_item.dart';
import 'package:week8/repositories/cart_repository.dart';

class CartViewModel extends BaseViewModel {
  final CartRepository _cartRepository;
  CartViewModel(this._cartRepository);

  List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;
  final List<OrderItem> _orderItem = [];

  Future<void> fetchCartItems() async {
    final result = await runBusyFuture(_cartRepository.getCart());

    if (result is Success<List<CartItem>>) {
      _cart = result.data;
      notifyListeners();
    } else if (result is Failure) {
      setError((result as Failure).message);
    }
  }
}

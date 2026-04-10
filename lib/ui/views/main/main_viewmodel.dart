import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:week8/ui/views/food_menu/food_menu_view.dart';
import 'package:week8/ui/views/orders/orders_view.dart';

class MainViewModel extends IndexTrackingViewModel {
  List<Widget> get views => const [FoodMenuView(), OrdersView()];
}

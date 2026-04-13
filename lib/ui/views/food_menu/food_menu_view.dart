import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:week8/core/utils/error_view.dart';
import 'package:week8/ui/views/food_menu/widgets/favroites_grid_view.dart';
import 'package:week8/ui/views/food_menu/widgets/meal_grid_view.dart';
import 'food_menu_viewmodel.dart';

class FoodMenuView extends StackedView<FoodMenuViewModel> {
  FoodMenuView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(FoodMenuViewModel viewModel) {
    viewModel.fetchMeals();
  }

  final GlobalKey cartKey = GlobalKey();

  @override
  Widget builder(
      BuildContext context, FoodMenuViewModel viewModel, Widget? child) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Food Menu"),
          backgroundColor: Colors.deepOrange,
          bottom: const TabBar(
            tabs: [Tab(text: 'menu'), Tab(text: 'favorites')],
          ),
          actions: [
            IconButton(
              onPressed: viewModel.toggleTheme,
              icon: const Icon(Icons.brightness_6),
            ),
            IconButton(
              key: cartKey,
              onPressed: viewModel.nav,
              icon: const Icon(Icons.shopping_cart),
            )
          ],
        ),
        body: TabBarView(
          children: [
            Builder(
              builder: (_) {
                if (viewModel.hasError) {
                  return ErrorView(message: viewModel.modelError!);
                }
                if (viewModel.isBusy) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!viewModel.hasMeals) {
                  return const Center(child: Text("No meals found"));
                }
                return MealGrid(
                  viewModel: viewModel,
                  cartKey:cartKey
                );
              },
            ),
            FavoritesGrid(viewModel: viewModel, cartKey: cartKey,),
          ],
        ),
      ),
    );
  }

  @override
  FoodMenuViewModel viewModelBuilder(BuildContext context) =>
      FoodMenuViewModel();
}

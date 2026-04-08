import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/repositories/cart_repository.dart';
import 'package:week8/services/theme_service.dart';

import 'food_menu_viewmodel.dart';

class FoodMenuView extends StackedView<FoodMenuViewModel> {
  FoodMenuView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(FoodMenuViewModel viewModel) {
    viewModel.fetchMeals();
  }

  final _themeService = locator<ThemeService>();
  final _cartReposotory = locator<CartRepository>();
  void toggleTheme() {
    _themeService.toggleTheme();
  }

  @override
  Widget builder(
    BuildContext context,
    FoodMenuViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Menu"),
        actions: [
          IconButton(
              onPressed: toggleTheme, icon: const Icon(Icons.brightness_6))
        ],
      ),
      body: viewModel.hasError
          ? const Center(
              child: Text(''),
            )
          : viewModel.isBusy
              ? const Center(child: CircularProgressIndicator())
              : viewModel.hasMeals
                  ? ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: viewModel.meals.length,
                      itemBuilder: (context, index) {
                        final meal = viewModel.meals[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: Image.network(
                              meal.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            title: Text(meal.name),
                            trailing: IconButton(
                              icon: const Icon(Icons.shopping_cart),
                              onPressed: () async {
                                viewModel.openAddToCartSheet(meal);
                              },
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text("No meals found"),
                    ),
    );
  }

  @override
  FoodMenuViewModel viewModelBuilder(BuildContext context) =>
      FoodMenuViewModel(_cartReposotory);
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/core/widgets/icon_text_widget.dart';
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
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
              onPressed: toggleTheme, icon: const Icon(Icons.brightness_6)),
          IconButton(
              onPressed: viewModel.nav, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: viewModel.hasError
          ? const Center(
              child: Text(''),
            )
          : viewModel.isBusy
              ? const Center(child: CircularProgressIndicator())
              : viewModel.hasMeals
                  ? GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: viewModel.meals.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final meal = viewModel.meals[index];

                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                  meal.image,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      meal.name,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    IconText(
                                      icon: Icons.star,
                                      text: meal.rating.toString(),
                                      iconColor: Colors.orange,
                                    ),
                                    const SizedBox(height: 4),
                                    IconText(
                                      icon: Icons.location_on,
                                      text: meal.area,
                                      iconColor: Colors.redAccent,
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: const Icon(Icons.shopping_cart),
                                  onPressed: () async {
                                    viewModel.openAddToCartSheet(meal);
                                  },
                                ),
                              ),
                            ],
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

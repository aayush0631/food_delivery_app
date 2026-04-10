import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:week8/core/widgets/icon_text_widget.dart';

import 'food_menu_viewmodel.dart';
import 'package:week8/models/meals.dart';

class FoodMenuView extends StackedView<FoodMenuViewModel> {
  const FoodMenuView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(FoodMenuViewModel viewModel) {
    viewModel.fetchMeals();
    viewModel.favoriteMealIds();
  }

  @override
  Widget builder(
    BuildContext context,
    FoodMenuViewModel viewModel,
    Widget? child,
  ) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Food Menu"),
          backgroundColor: Colors.deepOrange,
          bottom: const TabBar(tabs: [
            Tab(
              text: 'menu',
            ),
            Tab(
              text: 'favorites',
            )
          ]),
          actions: [
            IconButton(
                onPressed: viewModel.toggleTheme,
                icon: const Icon(Icons.brightness_6)),
            IconButton(
                onPressed: viewModel.nav, icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: TabBarView(children: [
          viewModel.hasError
              ? const Center(
                  child: Text(''),
                )
              : viewModel.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : viewModel.hasMeals
                      ? buildGrid(viewModel)
                      : const Center(child: Text("No meals found")),
          buildFavorites(viewModel),
        ]),
      ),
    );
  }

  @override
  FoodMenuViewModel viewModelBuilder(BuildContext context) =>
      FoodMenuViewModel();
}

Widget buildGrid(FoodMenuViewModel viewModel) {
  return GridView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: viewModel.meals.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.8,
    ),
    itemBuilder: (context, index) {
      final meal = viewModel.meals[index];
      return buildMealCard(viewModel, meal);
    },
  );
}

GestureDetector buildMealCard(FoodMenuViewModel viewModel, Meal meal) {
  return GestureDetector(
    onTap: () => viewModel.openMealDescription(meal),
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Hero(
            tag: meal.id,
            createRectTween: (begin, end) {
              return RectTween(begin: begin, end: end);
            },
            child: Image.network(
              meal.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          )),
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
              child: GestureDetector(
                onTap: () {
                  viewModel.addToFavorite(meal);
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: Tween<double>(begin: 0.6, end: 1.2).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.elasticOut,
                        ),
                      ),
                      child: RotationTransition(
                        turns: Tween<double>(begin: 0.0, end: 0.1)
                            .animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: Icon(
                    viewModel.favoriteMealIds.contains(meal.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    key: ValueKey(viewModel.favoriteMealIds.contains(meal.id)),
                    color: viewModel.favoriteMealIds.contains(meal.id)
                        ? Colors.red
                        : Colors.grey,
                    size: 28,
                  ),
                ),
              )),
        ],
      ),
    ),
  );
}

Widget buildFavorites(FoodMenuViewModel viewModel) {
  final favoriteMeals = viewModel.meals
      .where((meal) => viewModel.favoriteMealIds.contains(meal.id))
      .toList();

  if (favoriteMeals.isEmpty) {
    return const Center(child: Text("No favorites yet ❤️"));
  }

  return GridView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: favoriteMeals.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.8,
    ),
    itemBuilder: (context, index) {
      final meal = favoriteMeals[index];
      return buildMealCard(viewModel, meal);
    },
  );
}

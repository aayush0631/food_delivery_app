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
  const bool useSwitcher = true;
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.bounceInOut,
                  child: IconText(
                    icon: Icons.star,
                    text: meal.rating.toString(),
                    iconColor: Colors.orange,
                  ),
                ),
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
              child: useSwitcher
                  ? buildAnimatedSwitcher(viewModel, meal)
                  // ignore: dead_code
                  : buildAnimatedContainer(viewModel, meal),
            ),
          )
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

Widget buildAnimatedSwitcher(
    FoodMenuViewModel viewModel, Meal meal) {
  final isFav = viewModel.favoriteMealIds.contains(meal.id);

  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 300),
    transitionBuilder: (child, animation) {
      return ScaleTransition(
        scale: animation,
        child: child,
      );
    },
    child: Icon(
      isFav ? Icons.favorite : Icons.favorite_border,
      key: ValueKey(isFav), 
      color: isFav ? Colors.red : Colors.grey,
      size: 28,
    ),
  );
}

Widget buildAnimatedContainer(
    FoodMenuViewModel viewModel, Meal meal) {
  final isFav = viewModel.favoriteMealIds.contains(meal.id);

  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    curve: Curves.bounceOut,
    transform: isFav
        ? (Matrix4.identity()..scale(1.3))
        : Matrix4.identity(),
    child: Icon(
      isFav ? Icons.favorite : Icons.favorite_border,
      color: isFav ? Colors.red : Colors.grey,
      size: 28,
    ),
  );
}

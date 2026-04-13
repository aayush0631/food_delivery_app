import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:week8/core/widgets/icon_text_widget.dart';
import 'package:week8/core/utils/error_view.dart';
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
      BuildContext context, FoodMenuViewModel viewModel, Widget? child) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Food Menu"),
          backgroundColor: Colors.deepOrange,
          bottom:
              const TabBar(tabs: [Tab(text: 'menu'), Tab(text: 'favorites')]),
          actions: [
            IconButton(
              onPressed: viewModel.toggleTheme,
              icon: const Icon(Icons.brightness_6),
            ),
            IconButton(
              onPressed: viewModel.nav,
              icon: const Icon(Icons.shopping_cart),
            )
          ],
        ),
        body: TabBarView(children: [
          Builder(
            builder: (_) {
              if (viewModel.hasError) {
                return ErrorView(message: viewModel.modelError ?? "Error");
              }
              if (viewModel.isBusy) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!viewModel.hasMeals) {
                return const Center(child: Text("No meals found"));
              }
              return MealGrid(viewModel: viewModel);
            },
          ),
          FavoritesGrid(viewModel: viewModel),
        ]),
      ),
    );
  }

  @override
  FoodMenuViewModel viewModelBuilder(BuildContext context) =>
      FoodMenuViewModel();
}

class MealGrid extends StatelessWidget {
  final FoodMenuViewModel viewModel;
  const MealGrid({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
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
        return MealCard(viewModel: viewModel, meal: meal);
      },
    );
  }
}

class FavoritesGrid extends StatelessWidget {
  final FoodMenuViewModel viewModel;
  const FavoritesGrid({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
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
        return MealCard(viewModel: viewModel, meal: meal);
      },
    );
  }
}

class MealCard extends StatelessWidget {
  final FoodMenuViewModel viewModel;
  final Meal meal;
  const MealCard({super.key, required this.viewModel, required this.meal});

  @override
  Widget build(BuildContext context) {
    final isFav = viewModel.favoriteMealIds.contains(meal.id);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => viewModel.openMealDescription(meal),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Hero(
                  tag: meal.id,
                  child: Image.network(
                    meal.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
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
                          fontSize: 17, fontWeight: FontWeight.bold),
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
                  onPressed: () => viewModel.addToFavorite(meal),
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey(isFav),
                      color: isFav ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

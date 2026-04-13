import 'package:flutter/material.dart';
import 'package:week8/ui/views/food_menu/food_menu_viewmodel.dart';
import 'package:week8/ui/views/food_menu/widgets/meal_card_widget.dart';

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
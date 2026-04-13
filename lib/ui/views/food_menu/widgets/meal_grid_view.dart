import 'package:flutter/material.dart';
import 'package:week8/ui/views/food_menu/food_menu_viewmodel.dart';
import 'package:week8/ui/views/food_menu/widgets/meal_card_widget.dart';

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
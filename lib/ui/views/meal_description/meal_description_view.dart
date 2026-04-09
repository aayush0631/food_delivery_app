import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:week8/models/meals.dart';

import 'meal_description_viewmodel.dart';

class MealDescriptionView extends StackedView<MealDescriptionViewModel> {
  final Meal meal;
  const MealDescriptionView({Key? key, required this.meal}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MealDescriptionViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              meal.image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(meal.rating.toString()),
                  const SizedBox(height: 8),
                  Text(meal.instructions),
                  const SizedBox(height: 8),
                  Text(meal.area),
                  const SizedBox(height: 8),
                  Text(meal.category),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () async {
                          viewModel.openAddToCartSheet(meal);
                        },
                      ),
                      const Text('Add to cart'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(MealDescriptionViewModel viewModel) {
    viewModel.init(meal);
  }

  @override
  MealDescriptionViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MealDescriptionViewModel();
}

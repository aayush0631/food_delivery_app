

import 'package:flutter/material.dart';
import 'package:week8/core/widgets/icon_text_widget.dart';
import 'package:week8/models/meals.dart';
import 'package:week8/ui/views/food_menu/food_menu_viewmodel.dart';

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
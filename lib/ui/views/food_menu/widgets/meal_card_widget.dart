import 'package:flutter/material.dart';
import 'package:week8/core/widgets/icon_text_widget.dart';
import 'package:week8/models/meals.dart';
import 'package:week8/ui/views/food_menu/food_menu_viewmodel.dart';
import 'package:week8/ui/views/food_menu/widgets/add_to_cart_animation.dart';

class MealCard extends StatelessWidget {
  final FoodMenuViewModel viewModel;
  final Meal meal;
  final GlobalKey cartKey;
  MealCard(
      {super.key,
      required this.viewModel,
      required this.meal,
      required this.cartKey});
  final GlobalKey itemKey = GlobalKey();
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
                    key: itemKey,
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () async {
                          final confirmed =
                              await viewModel.openAddToCartSheet(meal);
                          if (!confirmed) return;
                          await Future.delayed(
                              const Duration(milliseconds: 300));
                          final startBox = itemKey.currentContext!
                              .findRenderObject() as RenderBox;
                          final endBox = cartKey.currentContext!
                              .findRenderObject() as RenderBox;
                          final start = startBox.localToGlobal(Offset.zero) +
                              Offset(startBox.size.width / 2,
                                  startBox.size.height / 2);
                          final end = endBox.localToGlobal(Offset.zero) +
                              Offset(endBox.size.width / 2,
                                  endBox.size.height / 2);
                          final size = startBox.size;
                          showFlyAnimation(
                              context, start, end, meal.image, size);
                        }),
                    IconButton(
                      onPressed: () => viewModel.addToFavorite(meal),
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                              scale: animation, child: child);
                        },
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          key: ValueKey(isFav),
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void showFlyAnimation(
  BuildContext context,
  Offset start,
  Offset end,
  String image,
  Size size,
) {
  final overlay = Overlay.of(context, rootOverlay: true);

  final entry = OverlayEntry(
    builder: (context) => AnimatedFlyWidget(
      start: start,
      end: end,
      image: image,
      size: size,
    ),
  );
  overlay.insert(entry);
  Future.delayed(const Duration(milliseconds: 1300), () {
    entry.remove();
  });
}

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
                          //opens bottom sheet and waits for user confirmation (true if user adds item)
                          final confirmed =
                              await viewModel.openAddToCartSheet(meal);
                          //if user cancels, stop execution
                          if (!confirmed) return;
                          //small delay to allow UI updates (like sheet closing) before measuring positions
                          await Future.delayed(
                              const Duration(milliseconds: 300));
                          //gets the RenderBox of the meal image widget using its GlobalKey
                          //RenderBox gives size and position info of the widget on screen
                          final startBox = itemKey.currentContext!
                              .findRenderObject() as RenderBox;
                          //gets the RenderBox of the cart icon using its GlobalKey
                          final endBox = cartKey.currentContext!
                              .findRenderObject() as RenderBox;
                          //gets the global screen position of the meal item (top-left corner)
                          //then shifts to center of the widget using width/2 and height/2
                          final start = startBox.localToGlobal(Offset.zero) +
                              Offset(startBox.size.width / 2,
                                  startBox.size.height / 2);
                          //gets the global screen position of the cart icon (top-left corner)
                          final end = endBox.localToGlobal(Offset.zero);
                          //stores size of the meal widget (used for animation scaling if needed)
                          final size = startBox.size;
                          //triggers overlay animation from start position to end position
                          if (context.mounted) {
                            showFlyAnimation(
                                context, start, end, meal.image, size);
                          }
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
  //gets the Overlay of the current screen to draw animation above all widgets
  final overlay = Overlay.of(context, rootOverlay: true);

  //creates an overlay entry which is a floating widget on top of UI
  final entry = OverlayEntry(
    builder: (context) => AnimatedFlyWidget(
      //starting position of animation (meal item)
      start: start,
      //ending position of animation (cart icon)
      end: end,
      //image to animate during the flight
      image: image,
      //original size of the widget (can be used for scaling)
      size: size,
    ),
  );

  //inserts the overlay entry into the overlay stack so it becomes visible
  overlay.insert(entry);

  //removes the overlay after animation duration to clean up UI
  Future.delayed(const Duration(milliseconds: 1300), () {
    entry.remove();
  });
}

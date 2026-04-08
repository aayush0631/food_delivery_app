import 'dart:math';

class Meal {
  final String id;
  final String name;
  final String image;
  final String category;
  final String area;
  final String instructions;
  final double price;
  final int rating;

  Meal({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.area,
    required this.instructions,
    required this.price,
    required this.rating,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    final random = Random();

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      image: json['strMealThumb'] ?? '',
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      instructions: json['strInstructions'] ?? '',
      price: json['price'] != null
          ? json['price'].toDouble()
          : 100 + random.nextInt(900) + random.nextDouble(),
      rating: json['rating'] ?? (random.nextInt(5) + 1),
    );
  }
}

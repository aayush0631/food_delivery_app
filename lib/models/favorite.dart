class Favorite {
  final int? id;
  final String mealId;
  final String mealName;
  final String mealImage;

  Favorite({
    this.id,
    required this.mealId,
    required this.mealName,
    required this.mealImage,
  });

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'],
      mealId: map['meal_id'],
      mealName: map['meal_name'],
      mealImage: map['meal_image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meal_id': mealId,
      'meal_name': mealName,
      'meal_image': mealImage,
    };
  }
}

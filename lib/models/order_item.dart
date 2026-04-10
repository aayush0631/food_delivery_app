class OrderItem {
  final int? id;
  final String mealId;
  final String mealName;
  final String mealImage;
  final double price;
  final int quantity;

  OrderItem({
    this.id,
    required this.mealId,
    required this.mealName,
    required this.mealImage,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'],
      mealId: map['meal_id'],
      mealName: map['meal_name'],
      mealImage: map['meal_image'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meal_id': mealId,
      'meal_name': mealName,
      'meal_image': mealImage,
      'price': price,
      'quantity': quantity,
    };
  }
}

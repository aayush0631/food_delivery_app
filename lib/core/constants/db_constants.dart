class DBTables {
  static const user = 'user';
  static const cart = 'cart';
  static const orderItems = 'order_items';
  static const favorites = 'favorites';
}

class UserColumns {
  static const id = 'user_id';
  static const name = 'name';
  static const email = 'email';
  static const password = 'password';
}

class CartColumns {
  static const id = 'id';
  static const mealId = 'meal_id';
  static const mealName = 'meal_name';
  static const mealImage = 'meal_image';
  static const price = 'price';
  static const quantity = 'quantity';
}

class OrderItemColumns {
  static const id = 'id';
  static const orderId = 'order_id';
  static const mealId = 'meal_id';
  static const mealName = 'meal_name';
  static const mealImage = 'meal_image';
  static const price = 'price';
  static const quantity = 'quantity';
}

class FavoriteColumns {
  static const id = 'id';
  static const mealId = 'meal_id';
  static const mealName = 'meal_name';
  static const mealImage = 'meal_image';
}

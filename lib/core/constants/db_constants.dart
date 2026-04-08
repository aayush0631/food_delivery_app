class DBTables {
  static const user = 'user';
  static const cart = 'cart';
  static const orders = 'orders';
  static const orderItems = 'order_items';
  static const favorites = 'favorites';
  static const delivery = 'delivery';
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

class OrderColumns {
  static const id = 'id';
  static const userId = 'user_id';
  static const totalAmount = 'total_amount';
  static const status = 'status';
  static const createdAt = 'created_at';
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

class DeliveryColumns {
  static const id = 'id';
  static const orderId = 'order_id';
  static const latitude = 'latitude';
  static const longitude = 'longitude';
  static const status = 'status';
}
